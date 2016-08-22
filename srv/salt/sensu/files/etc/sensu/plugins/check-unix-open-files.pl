#!/usr/bin/perl -w

use strict;
use Getopt::Long ;
Getopt::Long::Configure ("no_ignore_case") ;

use constant USAGEMSG => <<USAGE;

Usage:
check_unix_open_files -p <proc_name> -w <warn_threshold> -c <critical_threshold>

This plugin checks the number of file descriptors opened by a process

Example:
check_unix_open_files.pl -a nscd -w 20 -c 25
                                                
It returns CRITICAL if number of file descriptors opened by nscd is higher than 25.
if not it returns WARNING if number of file descriptors opened by nscd is higher than 20.
In other cases it returns OK if check has been performed succesfully.

USAGE

my ( $process, $warning, $critical ) ;

GetOptions("process|p=s"    => \$process,
           "warning|w=s"  => \$warning,
           "critical|c=s"    => \$critical)
      or Getopt::Long::HelpMessage(2);

$process and $warning and $critical or die USAGEMSG ;

my $PsCommand;
my $PsResult;
my @PsResultLines;
my $ProcPid;
my $LsofCommand;
my $LsofResult;
my $ProcCount = 0;

$PsCommand = "ps -eaf | grep $process";
$PsResult = `$PsCommand`;
@PsResultLines = split(/\n/, $PsResult);
if ( $#PsResultLines > 1 ) {
	foreach my $Proc (split(/\n/, $PsResult)) {
		if ($Proc !~ /check_unix_open_fds/ && $Proc !~ / grep /) {
			$ProcCount += 1;
			$ProcPid = (split(/\s+/, $Proc))[1];
			$LsofCommand = "sudo /usr/sbin/lsof -p $ProcPid | wc -l";
			$LsofResult = `$LsofCommand`;
			$LsofResult = ($LsofResult > 0 ) ? ($LsofResult - 1) : 0;
		}
	}
}

if ( $LsofResult >= $critical) {
	print "CRITICAL: $process has $LsofResult files open\n";
	exit 2;
} elsif ( $LsofResult >= $warning) {
        print "WARNING: $process has $LsofResult files open\n";
        exit 1;
} else {
print "OK: $process has $LsofResult files open\n";
        exit 0;
}
