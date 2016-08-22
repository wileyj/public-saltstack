#!/usr/bin/env ruby

require 'optparse'
require 'sys/proctable'
include Sys

class CheckPuppet

  VERSION = '0.1'
  script_name = File.basename($0)

  # default options
  OPTIONS = {
    :statefile => "/var/lib/puppet/state/state.yaml",
    :lockfile => "/var/lib/puppet/state/puppetdlock",
    :process   => "puppetd",
    :interval  => 30,
  }

  o = OptionParser.new do |o|
    o.set_summary_indent('  ')
    o.banner =    "Usage: #{script_name} [OPTIONS]"
    o.define_head "The check_puppet Nagios plug-in checks that specified Puppet process is running and the state file is no older than specified interval."
      o.separator   ""
      o.separator   "Mandatory arguments to long options are mandatory for short options too."


        o.on(
          "-s", "--statefile=statefile", String, "The state file",

    "Default: #{OPTIONS[:statefile]}") { |OPTIONS[:statefile]| }

        o.on(
          "-l", "--lockfile=lockfile", String, "The lock file",

    "Default: #{OPTIONS[:lockfile]}") { |OPTIONS[:lockfile]| }

      o.on(
        "-p", "--process=processname", String, "The process to check",

    "Default: #{OPTIONS[:process]}")   { |OPTIONS[:process]| }

      o.on(
        "-i", "--interval=value", Integer,

    "Default: #{OPTIONS[:interval]} minutes")  { |OPTIONS[:interval]| }
   
      o.on(
        "-w", "--warning=value", Integer,

    "Default: #{OPTIONS[:interval]} minutes")  { |OPTIONS[:interval]| }

      o.on(
        "-c", "--critical=value", Integer,

    "Default: #{OPTIONS[:interval]} minutes")  { |OPTIONS[:interval]| }

    o.separator ""
    o.on_tail("-h", "--help", "Show this help message.") do
      puts o
      exit
    end

    o.parse!(ARGV)
  end

  def check_proc

    unless ProcTable.ps.find { |p| p.name == OPTIONS[:process]}
      @proc = 2
    else
      @proc = 0
    end

  end

  def check_state

    # Set variables
    curt = Time.now
    intv = OPTIONS[:interval] * 60

    # Check file time
    begin
      @modt = File.mtime("#{OPTIONS[:statefile]}")
    rescue
      @file = 3
    end

    diff = (curt - @modt).to_i
    if diff > intv
      @file = 2
    else
      @file = 0
    end

    if File.file?("#{OPTIONS[:lockfile]}")
      if File.zero?("#{OPTIONS[:lockfile]}")
        @file = 4
      else
        @file = 5
      end
    end

    if File.file?("/etc/sysconfig/puppet_disable")
      if File.zero?("/etc/sysconfig/puppet_disable")
        @file = 6
      else
        @file = 7
      end
    end

  end

  def output_status

    case @file
    when 0
      state = "state file status okay updated on " + @modt.strftime("%m/%d/%Y at %H:%M:%S")
    when 2
      state = "state fille is not up to date and is older than #{OPTIONS[:interval]} minutes"
    when 3
      state = "state file status unknown"
    when 4
      state = "puppet is currently disabled.."
    when 5 
      state = "puppet is currently enabled and running..."
    when 6
      state = "puppet is currently disabled using the old method with an empty disable file..."
    when 7 
      state = "puppet is currently disabled using the old method.."
    end

    case @proc
    when 0
      process = "process #{OPTIONS[:process]} is running"
    when 2
      process = "process #{OPTIONS[:process]} is not running"
    end

    case @proc 
    when 0
      status = "OK"
      exitcode = 0
    when 2
      status = "CRITICAL"
      exitcode = 2
    end

    case @file
    when 3
      status = "UNKNOWN"
      exitcode = 3
    when 4
      status = "WARNING"
      exitcode = 1
    when 5
      status = "OK"
      exitcode = 0
    when 6
      status = "WARNING"
      exitcode = 1
    when 7
      status = "WARNING"
      exitcode = 1
    end

    puts "PUPPET #{status}: #{process}, #{state}"
    exit(exitcode)
  end
end

cp = CheckPuppet.new
cp.check_proc
cp.check_state
cp.output_status

