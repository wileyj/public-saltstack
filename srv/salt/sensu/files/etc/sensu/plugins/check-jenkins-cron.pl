#!/usr/bin/perl -w

# Check for periodic Jenkins jobs which have not run successfully.
#
# A re-written from scratch version of check_jenkins_job_extended.pl, focusing on jobs which are meant
# to be run periodically. This is designed to alert if there have been no successful builds within a
# timeframe, not just if a build has been failing for a duration. See usage output for options.
#
# 2012 Nick Robinson-Wall, Mendeley Ltd.

use strict;
use LWP;
use JSON; # deb: libjson-perl
use POSIX(); # for difftime(), don't import anything
use URI::Escape;
use Getopt::Std;

my $rcode = "UNKNOWN";
my $response = "Couldn't determine state of job";

my $jobname;
my $jobnameU; # URL Encoded job name
my $jenkins_ubase;
my $username;
my $password;
my $thresh_warn;
my $thresh_crit;
my $alert_on_fail;
my $alert_on_lastx_fail;
my $alert_on_nostart;
my $debug = 0;
my $timeout = 0;

sub main {
    # Getopts:
    # j: Job name
    # l: Jenkins URL
    # u: User (optional)
    # p: Password (optional)
    # w: Warning threshold
    # c: critical threshold
    # f: Alert on fail outside timeframe (optional)
    # a: Alert if last X builds were failed
    # t: timeout in seconds (optional)
    # s: Alert on situation when was never started
    # v: verbosity / debug (optional)
    my %opts;
    getopts('j:l:u:p:w:c:a:t:s:fv', \%opts);

    if (!$opts{j} || !$opts{l}) {
        print STDERR "Missing option(s)\n\n";
        &usage;
    }
    $debug = $opts{v};    
    if ($opts{'t'}) {
        $timeout = $opts{t};
    }
    $jobname = $opts{j};
    $jobnameU = uri_escape($opts{j});
    $jenkins_ubase = $opts{l};
	# Remove trailing slash in URL as a path will be appended
    $jenkins_ubase =~ s,/$,,;
	# Assume http:// if not specified
    $jenkins_ubase = "http://$jenkins_ubase" if($jenkins_ubase !~ m,^https?://,);
    print STDERR "Using Jenkins base URL: $jenkins_ubase\n" if $debug;
    $username = $opts{u};
    $password = $opts{p};
    $thresh_warn = int($opts{w});
    $thresh_crit = int($opts{c});
    $alert_on_nostart = $opts{s};
    $alert_on_fail = $opts{f};
    if ($opts{'a'}) {
        $alert_on_lastx_fail=int($opts{a});
        if ($alert_on_lastx_fail == 1) {
            $alert_on_fail = 1;
        }
    }
    
    if ($thresh_warn == 0 && $thresh_crit == 0) {
        print STDERR "Must set either warning or critical threshold to a sensible value\n\n";
        &usage;
    }
    
    my ($lb_status, $lb_resp, $lb_data) = apireq('lastBuild', $timeout);
    my ($ls_status, $ls_resp, $ls_data) = apireq('lastStableBuild', $timeout);
    my $ls_not_lb = 0;
    
    if ($ls_status || $lb_status) {
		# At least one of the API calls succeeded
        $ls_not_lb = 1 if ($ls_data->{number} != $lb_data->{number});
        my $dur_sec;
        my $dur_human;
        if ($ls_status) {
            ($dur_sec, $dur_human) = calcdur(int($ls_data->{timestamp} / 1000));
            if ($dur_sec >= $thresh_crit && $thresh_crit) {
                response("CRITICAL", "'$jobname' has not run successfully for $dur_human. " . ($ls_not_lb ? "Runs since failed. " : "No runs since. ") . $lb_data->{url} );
            } elsif ($dur_sec >= $thresh_warn && $thresh_warn && $ls_not_lb) {
                response("CRITICAL", "'$jobname' has not run successfully for $dur_human. Runs since failed. " . $lb_data->{url});
            } elsif ($dur_sec >= $thresh_warn && $thresh_warn) {
                response("WARNING", "'$jobname' has not run successfully for $dur_human. No runs since. " . $lb_data->{url})
            }
            
            if ($ls_data->{number} != $lb_data->{number} && $alert_on_fail and $alert_on_lastx_fail <= 1) {
                ($dur_sec, $dur_human) = calcdur(int($lb_data->{timestamp} / 1000));
                response ( "WARNING", "'$jobname' failed $dur_human ago. " . $lb_data->{url} );
            } elsif ($alert_on_lastx_fail > 1 && $lb_data->{number}-$ls_data->{number} >=$alert_on_lastx_fail) { # we should check on how many failed builds happened only if difference from last success and last build is equal or more than threahold value
                #request job status to get list of jobs and lastFailedBuild (it could differ from last build).
                my ($job_status, $job_resp, $job_data) = apireq('', $timeout);
                if ($job_status) {
                    my @jobs;
                    # prepare array with jobs that bigger than last stable and less than last failed
                    foreach my $key(@{$job_data->{builds}}) {
                        if ($key->{'number'} < $job_data->{lastFailedBuild}->{number} && $key->{'number'} > $job_data->{lastStableBuild}->{number}) {
                            push(@jobs, $key->{'number'});
                        }
                    }
                    my @jobst=reverse sort @jobs;
                    @jobs=@jobst;
                    # check whether count of jobs are bigger than threahold value
                    if (scalar @jobst >= $alert_on_lastx_fail - 1 ) {
                        my $failed_jobs=1; # set is to 1 as we already knew that lastFailedBuild was failed
                        my $count=1;
                        # get statuses of interesting jobs and stop checking them as only we reached threshold or understand that we can't it
                        while ($failed_jobs < $alert_on_lastx_fail && scalar @jobs > 0 && $count < 30 ) {
                            my $job = shift @jobs;
                            my ($jobf_status, $jobf_resp, $jobf_data) = apireq($job, $timeout);
                            if ($jobf_status && $jobf_data->{result} eq 'FAILURE') {
                                ++$failed_jobs;
                            }
                            ++$count;
                        }
                        if ($failed_jobs >= $alert_on_lastx_fail) {
                            response("CRITICAL", "'$jobname' was failed at least $failed_jobs time since last successfull build ".$job_data->{lastStableBuild}->{number}.". " . $lb_data->{url});
                        } else {
                            response ( "OK", "'$jobname' succeeded $dur_human ago, but with $failed_jobs failed jobs since last success. " . $lb_data->{url} );
                        }
                    } else {
                        response ( "OK", "'$jobname' succeeded $dur_human ago. " . $lb_data->{url} );
                    }
                } else {
                    response( "UNKNOWN", "Unable to retrieve data from Jenkins API: " . $job_resp );
                }
            } else {
                response ( "OK", "'$jobname' succeeded $dur_human ago. " . $lb_data->{url} );
            }
        } else {
            ($dur_sec, $dur_human) = calcdur(int($lb_data->{timestamp} / 1000));
            response ( 2, "'$jobname' has never run successfully. Last build was $dur_human ago." )
        }
    } else {
        if ($alert_on_nostart) {
            my ($job_status, $job_resp, $job_data) = apireq('', $timeout);
            if ($job_status) {
                response ( "WARNING", "'$jobname' has never run at all. Please check schedule." );
            } else {
                response( "UNKNOWN", "Unable to retrieve data from Jenkins API: " . $ls_resp );
            }
        } else {
            response( "UNKNOWN", "Unable to retrieve data from Jenkins API: " . $ls_resp );
        }
    }
    
    response($rcode, $response);
    
} # end sub main

# Calculate duration between unix epoch and now, using simplistic method to get the
# absolulte number of seconds between, and the human readable format.
sub calcdur($) {
    my $epoch = shift;

    my $timethen = $epoch;
    my $timenow = time();
    # Treat negative time difference as absolute value. When comparing such
    # result with a threshold later on, we would probably get the job as
    # outdated and report ERROR
    my $dur = POSIX::difftime($timenow, $timethen);
	my $absdur = abs ($dur);
    my $humandur = humanduration($dur);
    return ($dur, $humandur);
}

# Perform Jenkins JSON API request for $_ API call (lastBuild/lastStableBuild/lastSuccessfulBuild/lastFailedBuild etc)
sub apireq($) {
    my $job = shift;
    my $timeout = shift;
    my $url = "$jenkins_ubase/job/$jobnameU/$job/api/json";
    print STDERR "Preparing API URL for query: $url\n" if $debug;
    
    my $ua = LWP::UserAgent->new;
    if ($timeout) {
        $ua->timeout($timeout);
    }
    my $req = HTTP::Request->new( GET => $url );
    
    if ( $username && $password ) {
        print STDERR "Attempting HTTP basic auth as user: $username\n" if $debug;
        $req->authorization_basic($username,$password);
    } else {
        print STDERR "Skipping authentication, username and password not specified\n" if $debug;
    }
    
    my $res = $ua->request($req);
    
    if (!$res->is_success) {
        print STDERR "Request successful. Body:\n\n" . $res->content . "\n\n" if $debug;
        return ($res->is_success, $res->status_line, undef);
     } else {
        my $json = new JSON;
        my $jobj = $json->decode( $res->content );
        return ($res->is_success, $res->status_line, $jobj);
    }
}

# Produce a string like '2w 4d 7h 0m 12s' for the given duration in seconds.
# Redone without using DateTime to have no dependencies on it.
# Removes unneccessary units (e.g. won't display 0y 0mo when there are no years/months in the duration).
sub humanduration($) {
    my $dur = shift;
    my $res = "";
    my $zeroc = 0;
    my $multiplier;
    my $remainder;

    $remainder = $dur;
    # Years
    $multiplier = 365 * 24 * 60 * 60;
    my $years   = int ($remainder / $multiplier); $remainder %= $multiplier;
    # Months
    $multiplier = 30 * 24 * 60 * 60;
    my $months  = int ($remainder / $multiplier); $remainder %= $multiplier;
    # Weeks
    $multiplier = 7 * 24 * 60 * 60;
    my $weeks   = int ($remainder / $multiplier); $remainder %= $multiplier;
    # Days
    $multiplier = 24 * 60 * 60;
    my $days    = int ($remainder / $multiplier); $remainder %= $multiplier;
    # Hours
    $multiplier = 60 * 60;
    my $hours   = int ($remainder / $multiplier); $remainder %= $multiplier;
    # Minutes
    $multiplier = 60;
    my $minutes = int ($remainder / $multiplier); $remainder %= $multiplier;
    # Seconds
    my $seconds = $remainder;

    if ($years > 0 ) {
        $res .= sprintf "%dy ", $years;
        $zeroc = 1;
    }
    if ($months > 0 || $zeroc) {
        $res .= sprintf "%dmo ", $months;
        $zeroc = 1;
    }
    if ($weeks > 0 || $zeroc) {
        $res .= sprintf "%dw ", $weeks;
        $zeroc = 1;
    }
    if ($days > 0 || $zeroc) {
        $res .= sprintf "%dd ", $days;
        $zeroc = 1;
    }
    if ($hours > 0 || $zeroc) {
        $res .= sprintf "%dh ", $hours;
        $zeroc = 1;
    }
    if ($minutes > 0 || $zeroc) {
        $res .= sprintf "%dm ", $minutes;
        $zeroc = 1;
    }
    $res .= sprintf "%ds", $seconds;
    return $res;
}

sub response($$) {
    my ($code, $retstr) = @_;
	my %codemap = (
        OK       => 0,
		WARNING  => 1,
		CRITICAL => 2,
		UNKNOWN  => 3
    );
	
    print "$code - $retstr";
    exit $codemap{$code};
}

sub usage {
    print << "EOF";
usage: $0 -j <job> -l <url> -w <threshold> -c <threshold> [-f] [-u username -p password] [-a count] [-s] [-t seconds] [-v]
    
    Required arguments
        -j <job>        : Jenkins job name
                          The name of the job to examine.
                          
        -l <url>        : Jenkins URL
                          Protocol assumed to be http if none specified.
                          
        -w <threshold>  : Warning Threshold (seconds)
                          WARNING when the last successful run was over <threshold> seconds ago.
                          CRITICAL when last successful run was over <threshold> and failures
                          have occured since then.
                          
        -c <threshold>  : Critical Threshold (seconds)
                          CRITICAL when the last successful run was over <threshold> seconds ago.
                           
    Optional arugments
        -f              : WARNING when the last run was not successful, even if the last
                          successful run is within the -w and -c thresholds.

        -a <count>      : WARNING when last <count> builds were not successful.
                          -a 1 means the same as -f

        -s              : WARNING when job was never started at all
                          
        -u <username>   : Jenkins Username if anonymous API access is not available
        
        -p <password>   : Jenkins Password if anonymous API access is not available

        -t <seconds>    : Timout value when requesting to API, 180 by default
        
        -v              : Increased verbosity.
EOF
    exit 3;
}

&main;
