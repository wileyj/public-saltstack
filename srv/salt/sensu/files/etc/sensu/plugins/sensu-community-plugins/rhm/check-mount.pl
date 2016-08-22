#!/usr/bin/perl
#
# check_mount.pl - checks various aspects of mountpoints
#
# usage: check_mount.pl [check_type] [options]
#
############################################################################
##                                                                        ##
## This program is free software: you can redistribute it and/or modify   ##
## it under the terms of the GNU General Public License as published by   ##
## the Free Software Foundation, either version 3 of the License, or      ##
## (at your option) any later version.                                    ##
##                                                                        ##
## This program is distributed in the hope that it will be useful,        ##
## but WITHOUT ANY WARRANTY; without even the implied warranty of         ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          ##
## GNU General Public License for more details.                           ##
##                                                                        ##
## You should have received a copy of the GNU General Public License      ##
## along with this program.  If not, see <http://www.gnu.org/licenses/>.  ##
##                                                                        ##
## © 2013 Jesse Wiley <jesse.wiley.viacom.com                             ##
##                                                                        ##
############################################################################
use strict;
use Switch;

my $debug = 0 ;

my $check_type = shift ;

my $hostname = `hostname` ;
chomp($hostname) ;

my @options = @ARGV ;

print "$check_type @options\n" if ($debug) ;
switch ($check_type) {
case "space" {
  my ( $mount, $warn, $critical ) = @options ;
  open ( DF, "df -kP $mount | grep -v Filesystem |" ) ;
  while ( my $dfline = <DF> ) {
    chomp ( $dfline ) ;
    print STDERR "$dfline\n" if ($debug) ;
    if ( $dfline =~ /.*\s+$mount$/ ) {
      my ($device, $kfree, $pctused) = ("", 0, 100) ;
      print "$dfline : matched\n" if ($debug) ;
      $dfline =~ /^(\S+).*\s+(\S+)\s+(\S+)\%\s+$mount$/ ;
      ($device, $kfree, $pctused) = ($1, $2, $3) ;
      if ( ( 100 - $pctused ) <= $critical ) {
        print "critical: $device on $mount - $pctused% used, ${kfree}KB free\n" ;
        exit (2) ;
      } elsif ( ( 100 - $pctused ) <= $warn ) {
        print "warning: $device on $mount - $pctused% used, ${kfree}KB free\n" ;
        exit (1) ;
      } elsif ( ( 100 - $pctused ) > $warn ) {
        print "ok: $device on $mount - $pctused% used, ${kfree}KB free\n" ;
        exit (0) ;
      } else {
        print "critical: unknown condition\n" ;
        exit (2) ;
      }
    }
  }
  print "critical: mount $mount not found\n" ;
  exit (2) ;
} 
case "nfs" {
  my %wantopt ;
  my ( $remote, $mount, $wantoptions ) = @options ;
  my $wrongopt = 0 ;
  my @missedopt = () ;
  my @wantoptions = split(/,/, $wantoptions) ;
  foreach my $wantopt ( @wantoptions ) {
    $wantopt{$wantopt} = 1 ;
  }
  open ( MOUNT, "mount | grep 'type nfs' |" ) ;
  while ( my $mountline = <MOUNT> ) {
    if ( $mountline =~ /^$remote\s+on\s+$mount\s+.*\((.*)addr/ ) {
      # test for stale NFS mount.
      open ( DF, "df -kP $mount 2>&1 && echo $? |" ) || die "unable to run DF -- $!\n";
      my $ll = ''; my @stdout;
      while(<DF>) {
        chomp;
        push(@stdout, $_);
        $ll = $_;
      }
      close(DF);
      if ( $ll =~ /Stale/ ) {
        print "CRITICAL: NFS mount: $mount is STALE\n";
        exit(2);
      }
      # this has been tested, and it works.

      my @realoptions = split(/,/, $1) ;
      if ( $wantopt{rw} == 1 ) {
        if ( -d "$mount/.nfs" ) {
          if ( system("touch $mount/.nfs/nfstest-$hostname &> /dev/null && rm -f $mount/.nfs/nfstest-$hostname &> /dev/null") ) {
             print "critical: $remote mounted on $mount rw, .nfs directory found, not writeable\n";
             exit (2) ;
          }
        } else {
          if ( system("grep isteamsite $mount &> /dev/null") ) {
            my $realopt = join(',', @realoptions) ;
            print "ok: $remote mounted on $mount with options $realopt\n" ;
            exit (0);
          } else {
            print "critical: $remote mounted on $mount rw, but no .nfs directory\n" ;
            exit (1) ;
          }
        }
      }
      foreach my $realopt ( @realoptions ) {
        $wantopt{$realopt} = 0 ;
      }
      foreach my $finalopt ( keys %wantopt ) {
        if ( $wantopt{$finalopt} == 1 ) {
          push ( @missedopt, $finalopt ) ;
          $wrongopt = 1 ;
        }
      }
      if ( $wrongopt ) {
        my $missedopt = join(',', @missedopt) ;
        print "critical: $remote mounted on $mount without options $missedopt\n" ;
        exit (2) ;
      } else {
        my $realopt = join(',', @realoptions) ;
        print "ok: $remote mounted on $mount with options $realopt\n" ;
        exit (0) ;
      }
    }
  }
  print "critical: $remote not mounted on $mount\n" ;
  exit (2) ;
}
else { 
        print "unknown: check command not defined correctly! USAGE: check_mount.pl [nfs\|space] OPTIONS\n";
        exit (3) ;
    }
}

