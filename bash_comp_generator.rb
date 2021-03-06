#!/usr/bin/env ruby

require 'erubis'
require 'json'

if ARGV.empty? || (ARGV[0] =~ /--?h(elp)?/)
  puts <<-EOF
usage: #{$0} <json_file>

This script reads a JSON file (generated by cloudstack_api_generator.rb) and
prints a corresponding bash completion function to stdout.  Save the output to
a file somewhere and source it within your bashrc to have tab-completable
arguments and parameters for the `cloud-api' script.

Example:
  $ #{$0} api_2.2.14.json > cloud-api-comp

  EOF
  exit(1)
end

begin
  commands = JSON.load(open(ARGV[0]))
  template = File.read("cloud-api-comp.erb")
  eruby = Erubis::Eruby.new(template)
  puts eruby.result(binding)
rescue => e
  puts "#{e.message}"
  exit(1)
end

