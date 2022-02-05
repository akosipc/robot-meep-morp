#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/commander'

puts '--------------------'
puts '|Available Commands|'
puts '--------------------'
puts '| PLACE X,Y,F      |'
puts '| MOVE             |'
puts '| LEFT             |'
puts '| RIGHT            |'
puts '| REPORT           |'
puts '--------------------'

def start_application
  application_loop(Commander.new(reporting: true))
rescue Commander::MissingRobotError, Commander::ReadError => e
  puts e
  start_application
end

def application_loop(cobra_commander)
  loop do
    print 'Command: '
    cobra_commander.read_command(gets.chomp.strip)
  end
end

start_application
