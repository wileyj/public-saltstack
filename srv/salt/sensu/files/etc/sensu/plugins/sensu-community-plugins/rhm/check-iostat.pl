#!/usr/bin/perl

#major scsi block = 8 : minor is 0,16,32,48,64 etc
# ex: /dev/sda=8,0 : /dev/sdb=8,16 : /dev/sdc=8,32
#major ide block = 3 - same minor numbers
# xen disks = 202 - same minor numbers
$debug=0;
$ignore=0;
$nodisk_found=1;
$disk_count=0;
$num_skipped=0;
$tempfile="/tmp/statsfile";
if (!-f "$tempfile"){
  logger("NOT FOUND: $tempfile)",1);
  logger("Creating $tempfile before continuing\n", 1);
  open (STATSFILE, ">$tempfile");
  close STATSFILE;
  $ignore=1;
}
if (-f "$tempfile"){
  $filesize= (stat($tempfile))[7];
  if ($filesize <= 1){
    $ignore=1;
  }
}
$date=time;
$statsfile="/proc/diskstats";
if (!-f $statsfile){
  $state=2;
  $message="CRIT: missing /proc/diskstats";
logger("return 31\n",1);
  &return;
}
$multiple=0;
open (STATS, "$statsfile");
@stats=<STATS>;
close STATS;
open(READ, "$tempfile");
@readlines=<READ>;
close READ;
$previoustime=0;
$currenttime=$date;
$readline_len=scalar(@readlines);
logger("Readline_len: $readline_len", 1);
my %old=();
my %new=();
if ($readline_len > 0){
  foreach $read(@readlines){
    chomp $read;
     logger("Line: $read", 1);
    @get=split(" ", $read);
    logger("Reading Old Values of /dev/$get[1]", 1);
    $old_device=$get[1];
    $old_read=$get[2];
    $old_write=$get[3];
    $previoustime=$get[0];
    $old{$old_device}->{'device'}=$old_device;
    $old{$old_device}->{'read'}=$old_read;
    $old{$old_device}->{'write'}=$old_write;
    $old{$old_deivce}->{'time'}=$previoustime;
  }
  logger("Getting Time Difference...", 1);
  $time=$currenttime-$previoustime;
   logger("Elapsed time is: $time s", 1);
}else{
  if ($ignore == 1){
    $state=2;
    $message="Created $tempfile";
  }else{
    $state=1;
    $message="No data in $tempfile";
  }
  logger("return 71", 1);
  &return;
}
open (WRITE, ">$tempfile");
$stats_len=scalar(@stats);
logger("stats_len: $stats_len", 1);
foreach $line(@stats){
  logger("Reading $statsfile...", 1);
  $skip = 0;
  chomp $line;
  @splitline=split(" ", $line);

  if ($splitline[0] == 202 || $splitline[0] == 8 || $splitline[0] == 3){
      logger("Line: $line", 1);
    $nodisk_found=0;
    @splitthis=split(" ", $line);
    logger("splitthis[2]: $splitthis[2]",1);
    if ($splitthis[2]=~/\b[0-9]/){}
    else{
      logger("disk_count: $disk_count", 1);
      $disk_count++;
      $device=$splitthis[2];
      $read=$splitthis[5];
      $write=$splitthis[7];
      if ($device =~/\b[0-9]/)   { $skip = 1;logger("skipping because of device: $device",1);}
      if ($read  =~/[a-zA-Z]/) { $skip = 1; logger("skipping because of read: $read",1);}
      if ($write =~/[a-zA-Z]/) { $skip = 1; logger("skipping because of write: $write",1);}

      if ($device=~/[a-zA-Z]/ && $skip == 0){
        $old_read=$old{$device}->{'read'} if ($ignore != 1);
        $old_write=$old{$device}->{'write'} if ($ignore != 1);
        print WRITE "$date $device $read $write\n";
        if ($ignore != 1){
          $readspeed=(($read-$old_read)/$time)*512;
          $writespeed=(($write-$old_write)/$time)*512;
          logger("origread: $readspeed", 1);
          $readspeed=0.1*int(0.5+$readspeed/0.1);
          logger("roundread: $readspeed", 1);
          logger("origwrite: $writespeed", 1);
          $writespeed=0.1*int(0.5+$writespeed/0.1);
          logger("roundwrite: $writespeed", 1);
        }
        if ($readspeed > 1024){
          $readspeed=$readspeed/1024;
          $speed="kb";
        }else{
          $speed="b";
        }
        if ($writespeed > 1024){
          $writespeed=$writespeed/1024;
          $speed="kb";
        }else{
          $speed="b";
        }
        if ($ignore != 1){
          logger("------- Details for /dev/$device -------\n", 1);
          logger("Read Speed: $readspeed $speed/s\n", 1);
          logger("Write Speed: $writespeed $speed/s\n", 1);
          logger("\n",1);
          $state=0;
          $message="$message"."/dev/$device: read=$readspeed $speed/s | write=$writespeed $speed/s\n";
          logger("Message: $message", 1);
        }
      }else{
        $num_skipped++;
        $skipped_devices="$skipped_devices"." /dev/$device";
        logger("SKipped Devices: $skipped_devices",1 );
      }
    }
  } 
}
if ($nodisk_found == 1){
  $state=2;
  $message="CRIT: no disks found";
  logger("return 130", 1);
  &return;
}
if ($num_skipped > 0){
  $state=2;
  $message="CRIT: problem reading info or disks: $skipped_devices";
   logger("return 136", 1);
  &return;
}
 logger("return 139", 1);
&return;
close WRITE;

sub return(){
  logger("in return", 1);
  logger("state: $state", 0);
  logger("message: $message", 0);
}
sub logger{
  my $data = $_[0];
  my $type = $_[1];
  if ($type == 0){
    print "$data\n";
  }else{
    print "DEBUG $data\n" if ($debug);
  }
}
