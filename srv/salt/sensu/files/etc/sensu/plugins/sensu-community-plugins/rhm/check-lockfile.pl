#!/usr/bin/perl

############################## check_lockfile.pl ##############
# Version : 0.1
# Author  : Jason Rojas
# Licence : GPL - http://www.fsf.org/licenses/gpl.txt
###########################################################

use strict;
use Getopt::Long;
use File::stat;
use Time::localtime;

my $Version='0.1';
my %ERRORS=('OK'=>0,'WARNING'=>1,'CRITICAL'=>2,'UNKNOWN'=>3,'DEPENDENT'=>4);

my $o_help=undef;          # wan't some help ?
my $o_version=undef;       # print version
my $v_debug=undef;        # Check if a file doesn't exist
my $o_age=undef;        # Check if file is older than X seconds
my $o_file=undef;        # Check if file is older than X seconds
my $o_paramok=undef;

sub print_version {
  print "check_file version : $Version\n";
}

sub print_usage {
    print "Usage: check_file.pl [-v] [-h] -a <age> -f <file>\n";
}

sub print_help {
  print "\nNagios Plugin to check if a lock file exist/doesn't exist, and how old it is..\n";
  print "This will also compare the age of the file, this is best used for lock files..\n\n";
  print_usage();
  print <<EOT;
-v, --version
  Print version of this plugin
-h, --help
   Print this help message
-a, --age
   Go critical if file age is greater than X seconds.
-f, --file
   File to perform the check on.
-d, --debug
   what do you think?
EOT
}

sub check_options {
  Getopt::Long::Configure("bundling");
  GetOptions(
    'h'     => \$o_help,            'help'          => \$o_help,
    'v'     => \$o_version,         'version'       => \$o_version,
    'd'       => \$v_debug,     'debug'     => \$v_debug,
    "a=s"     => \$o_age,           "age=s"         => \$o_age,
    "f=s"     => \$o_file,          "file=s"        => \$o_file,
  );
  
  if (defined ($o_help)) { print_help(); exit $ERRORS{"UNKNOWN"}};
  if (defined ($o_version)) { print_version(); exit $ERRORS{"UNKNOWN"}};
  if (!defined ($o_file) && !defined ($o_age)) { print_usage(); exit $ERRORS{"UNKNOWN"}};;
}

###### MAIN ######

check_options();



print "Checking $o_file \n" if $v_debug;
my $datetime = (stat($o_file))[9];
print "File mtime: $datetime \n" if $v_debug;
my $curtime = time;
print "Current time: $curtime \n" if $v_debug;
my $age = $curtime - $datetime;
print "Current file age: $age \n" if $v_debug;
my $exit_status = $ERRORS{"OK"};

  if (! -e $o_file) {
    print "File " . $o_file . " does not exist.\n";
  exit $ERRORS{"OK"};
  }
  else {
    print "File: " . $o_file . " exists!!!\n";
    $exit_status = $ERRORS{"CRITICAL"};
  }
if (defined ($o_age)) {
print "Checking: $age vs $o_age\n" if $v_debug;
  if ($age < $o_age) {
  $exit_status = $ERRORS{"OK"};
  print "File is only $age seconds old..\n";
  } else {
  $exit_status = $ERRORS{"CRITICAL"};
  print "File is $age seconds old!\nPlease check the buildmap process!\n";
}
}
exit $exit_status;
