#!/usr/bin/perl

if ($ARGV[0] eq "-d"){
  $debug = 1;
}

# open (FILE, ">/etc/pam.d/sshd");
# close FILE;
# open (FILE, ">>/etc/pam.d/sshd");
# print FILE "#%PAM-1.0
# auth     required pam_sepermit.so
# auth       include      password-auth
# account    required     pam_nologin.so
# account    include      password-auth
# password   include      password-auth
# # pam_selinux.so close should be the first session rule
# session    required     pam_selinux.so close
# session    required     pam_loginuid.so
# # pam_selinux.so open should only be followed by sessions to be executed in the user context
# session    required     pam_selinux.so open env_params
# session    optional     pam_keyinit.so force revoke
# session    include      password-auth
# session required pam_chroot.so";
# close FILE;


print "Creating Jailed root init\n" if ($debug);
if (! -d "/export/jail/lib64"){
  system("mkdir -p /export/jail/lib64 > /dev/null 2>&1");
}
if (! -d "/export/jail/usr/share/terminfo"){
  system("mkdir -p /export/jail/usr/share/terminfo > /dev/null 2>&1");
}
if (! -d "/export/jail/usr/lib64"){
  system("mkdir -p /export/jail/usr/lib64 > /dev/null 2>&1");
}
if (! -d "/export/jail/etc"){
   system("mkdir -p /export/jail/etc > /dev/null 2>&1");
}
system("cp -a /lib64/libnss* /export/jail/lib64/ > /dev/null 2>&1");
system("cp -a /usr/lib64/libnss* /export/jail/usr/lib64/ > /dev/null 2>&1");
system("cp -a /etc/nsswitch.conf /export/jail/etc/nsswitch.conf > /dev/null 2>&1");
system("cp -a /etc/hosts /export/jail/etc/hosts > /dev/null 2>&1");
system("cp -a /etc/system-release /export/jail/etc/system-release > /dev/null 2>&1");
system("cp -a /etc/security /export/jail/etc/security > /dev/null 2>&1");
system("cp -a /usr/share/terminfo/x /export/jail/usr/share/terminfo/ > /dev/null 2>&1");

open (FILE, ">/export/jail/etc/zshenv");
close FILE;
open (FILE, ">>/export/jail/etc/zshenv");
print FILE '#
# /etc/zshenv is sourced on all invocations of the
# shell, unless the -f option is set.  It should
# contain commands to set the command search path,
# plus other important environment variables.
# .zshenv should not contain commands that produce
# output or assume the shell is attached to a tty.
#

export PATH=/usr/bin:/bin
alias bindkey=""
alias compcall=""
alias compctl=""
alias compsys=""
alias source=""
alias vared=""
alias zle=""
alias bg=""

disable compgroups
disable compquote
disable comptags
disable comptry
disable compvalues
disable pwd
disable alias
disable autoload
disable break
disable builtin
disable command
disable comparguments
disable compcall
disable compctl
disable compdescribe
disable continue
disable declare
disable dirs
disable disown
disable echo
disable echotc
disable echoti
disable emulate
disable enable
disable eval
disable exec
disable export
disable false
disable float
disable functions
disable getln
disable getopts
disable hash
disable integer
disable let
disable limit
disable local
disable log
disable noglob
disable popd
disable print
disable pushd
disable pushln
disable read
disable readonly
disable rehash
disable sched
disable set
disable setopt
disable shift
disable source
disable suspend
disable test
disable times
disable trap
disable true
disable ttyctl
disable type
disable typeset
disable ulimit
disable umask
disable unalias
disable unfunction
disable unhash
disable unlimit
disable unset
disable unsetopt
disable vared
disable whence
disable where
disable which
disable zcompile
disable zformat
disable zle
disable zmodload
disable zparseopts
disable zregexparse
disable zstyle';
close FILE;

print "Creating rzshuser homedir\n" if($debug);
if (! -d "/export/jail/home/rzshuser/.ssh"){
  system("mkdir -p /export/jail/home/rzshuser/.ssh > /dev/null 2>&1");
}
if (! -d "/export/jail/dev"){
  system("mkdir -p /export/jail/dev > /dev/null 2>&1");
}
if (! -c "/export/jail/dev/null"){
  system("mknod /export/jail/dev/null c 1 3 > /dev/null 2>&1");
  system("chmod 666 /export/jail/dev/null > /dev/null 2>&1");
}
if (!-c "/export/jail/dev/random"){
  system("mknod /export/jail/dev/random c 1 8 > /dev/null 2>&1");
  system("chmod 666 /export/jail/dev/random > /dev/null 2>&1");
}
if (!-c "/export/jail/dev/tty"){
  system("mknod /export/jail/dev/tty c 1 8 > /dev/null 2>&1");
  system("chmod 666 /export/jail/dev/tty > /dev/null 2>&1");
}
if (!-c "/export/jail/dev/urandom"){
  system("mknod /export/jail/dev/urandom c 1 9 > /dev/null 2>&1");
  system("chmod 666 /export/jail/dev/urandom > /dev/null 2>&1");
}

print "Linking /dev/null to rzshuser know_hosts files\n" if($debug);
if (!-l "/export/jail/home/rzshuser/.ssh/known_hosts"){
  system("ln -s /export/jail/dev/null /export/jail/home/rzshuser/.ssh/known_hosts > /dev/null 2>&1");
}
if (!-l "/export/jail/home/rzshuser/.ssh/known_hosts2"){
  system("ln -s /export/jail/dev/null /export/jail/home/rzshuser/.ssh/known_hosts2 > /dev/null 2>&1");
}

system("echo > /etc/zprofile");
system("echo > /etc/zlogout");
system("echo > /etc/zshrc");
system("echo > /etc/profile.d/lang.sh");
system("echo > /etc/profile");

%list=(
  '/usr/bin/strace'               => 'strace.x86_64',
  '/usr/bin/host'                 => 'bind-utils.x86_64',
  '/bin/ping'                     => 'iputils.x86_64',
  '/bin/rzsh'                     => 'zsh.x86_64',
  '/bin/traceroute'               => 'traceroute.x86_64',
  '/usr/bin/dig'                  => 'bind-utils.x86_64',
  '/usr/bin/nslookup'             => 'bind-utils.x86_64',
  '/usr/bin/ssh'                  => 'openssh-clients.x86_64',
  '/usr/bin/telnet'               => 'telnet.x86_64',
);
while (my ($key, $value) = each (%list) ){
  if ( !-f $key){
    yuminstall($value);
    if ($? == 0){
      runldd($key);
    }
  }else{
    runldd($key);
  }
  if ($? == 0){
    copylibs($get_ldd, $key);
  }
}

if (! -d "/export/jail/dev/pts"){
  system("mkdir -p /export/jail/dev/pts");
  system("mount --bind /dev /export/jail/dev");
  system("mount -t devpts -o gid=5,mode=620 devpts /export/jail/dev/pts");
}

if (! -d "/export/jail/proc"){
  print "creating dir /export/jail/proc" if ($debug);
  system("mkdir -p /export/jail/proc");
  print "mounting /export/jail/proc" if ($debug);
  system("mount -t proc /proc /export/jail/proc/");
}

if (! -d "/export/jail/sys"){
  print "creating dir /export/jail/sys" if ($debug);
  system("mkdir -p /export/jail/sys");
  print "mounting /export/jail/sys" if ($debug);
  system("mount --bind /sys /export/jail/sys");
}
system("grep chroot /etc/fstab > /dev/null 2>&1");
if ($? != 0){
  open (FILE, ">>/etc/fstab");
  @lines=<FILE>;
  $found=0;
  foreach $line(@lines){
    if ($line =~/chroot/){
      $found = 1;
    }
  }
  print "printing /etc/fstab" if ($debug);
  print FILE"
# chroot
proc\t/export/jail/proc\tproc\tnosuid,noexec,nodev\t0     0
sysfs\t/export/jail/sys\tsysfs\tnosuid,noexec,nodev\t0     0
devpts\t/export/jail/dev/pts\tdevpts\trw,gid=5,mode=620\t0 0
/dev\t/export/jail/dev\tdefaults\trw,bind\t0 0
" unless $found == 1;
  close FILE;
}
system("chmod u+s /export/jail/bin/ping");

# https://www.snort.org/#get-started
#system("yum install https://www.snort.org/downloads/snort/daq-2.0.2-1.centos6.x86_64.rpm");
#system("yum install https://www.snort.org/downloads/snort/snort-2.9.6.2-1.centos6.x86_64.rpm.sig");

open (OUT, ">> /etc/sysconfig/chroot_setup");
print OUT "1";
close OUT;

exit 0;
sub yuminstall{
  $package = $_[0];
  print "Installing package $package\n" if($debug);
  system("yum install -y $package");
  return $?;
}
sub runldd{
  $binary = $_[0];
  print "running ldd on $binary" if ($debug);
  $get_ldd = `/usr/bin/ldd $binary `;
  return $?;
}
sub copylibs{
  $ldd = $_[0];
  $bin = $_[1];
  print "ldd: $ldd\n" if ($debug);
  print "bin: $bin\n" if ($debug);
  @split = split("\n", $ldd);
  $count=0;
  foreach $line(@split){
    $islink=0;
    if ($line!~/linux-vdso/){
      chomp $line;
      @split2 = split(" ", $line);
      $firstchar = substr($split2[0],0,1);
      if ($firstchar eq "/"){
        $lib = $split2[0];
      }else{
        $lib = $split2[2];
      }
      if (-l $lib){
        $islink=1;
        $link = readlink($lib);
        print "found link: $link\n" if ($debug);
      }
      @jail_l = split('', $lib);
      $len_l=scalar(@jail_l);
      $loc_l = 0;
      for ($i=0; $i<$len_l; $i++){
        if ($jail_l[$i] eq "/"){
          $loc_l = $i;
        }
      }
      $base_l = substr($lib,0,$loc_l);
      print "base_l: $base_l\n" if ($debug);
      $makedir_l = "/export/jail"."$base_l";
      if($islink == 1){
        $link_loc="$base_l"."/"."$link";
        $link_jail_loc="/export/jail"."$base_l"."/"."$link";
        if (!-f $link_jail_loc){
          print "Copying link source: $link_loc\n" if($debug);
          system("cp -R $link_loc $link_jail_loc");
        }
      }
      $lib_jail ="/export/jail"."$lib";
      if (!-d $makedir_l){
        print "Creating Dir: $makedir_l\n" if($debug);
        system("mkdir -p $makedir_l");
      }
      if(!-f $lib_jail){
        print "Copying lib $lib to $lib_jail\n" if($debug);
        system("cp -R $lib  $lib_jail");
      }
    }
  }
  @jail_b = split('', $bin);
  $len_b=scalar(@jail_b);
  $loc_b = 0;
  for ($j=0; $j<$len_b; $j++){
    if ($jail_b[$j] eq "/"){
      $loc_b = $j;
    }
  }
  $base_b = substr($bin,0,$loc_b);
  $makedir_b = "/export/jail"."$base_b";
  $bin_jail = "/export/jail"."$bin";
  if(!-d $makedir_b){
    print "Creating dir: $makedir_b\n" if($debug);
    system("mkdir -p $makedir_b");
  }
  if (!-f  $bin_jail){
    print "Copying binary $bin to $bin_jail\n" if($debug);
    system("cp -R $bin $bin_jail");
  }
}
$get_suid=`find /export/jail ! -path "*/proc*" -perm -4000 -type f`;
@suid_s = split("\n", $get_suid);
foreach $suid_file(@suid_s){
  chomp $suid_file;
  if ($file!~/ping/){
    print "Removing suid from $suid_file\n" if($debug);
    system("chmod u-s $suid_file");
  }
}
