#!/usr/bin/perl
#use strict;

#
# Checks if a socket is open on $host. 
# Pass arguments to script -p Port and -h Host
#

use warnings;
use IO::Socket::INET;
use POSIX;
use Getopt::Long;

my $failed;
my $host;
my $port;
my $debug;

GetOptions(
       "debug"         => \$debug,
       "host=s"        => \$host,
       "port=s"        => \$port
);

if (!$host || !$port){
   print "Invalid args\n";
   exit 3;
}else{
   print "Host: $host\n" if ($debug);
   print "Port: $port\n" if ($debug);
   $failed=0;
   my $sock= IO::Socket::INET->new(
       PeerAddr => $host,
       PeerPort => $port,
       Proto    => 'tcp',
       Timeout  => 1
   ) or $failed=1;
   if ($failed == 0){
       print "$host $port OPEN\n";
       exit 0;
   }else{
       print "$host $port CLOSED\n";
       exit 2;
   }
}