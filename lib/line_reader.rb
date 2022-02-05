require 'byebug'
require_relative './robot'

class LineReader
  class ReadError < StandardError; end
  class BotArgumentError < StandardError; end

  COMMANDS = ['move', 'left', 'right', 'report'].freeze
  PLACE_REGEX = /(?i)(place) ([0-4]),([0-4]),(north|west|south|east)/

  class << self
    def read(line)
      raise ReadError, 'No argument was sent' if line.nil? || line.empty?

      if line.downcase.include?('place')
        raise ReadError, "Place command is not valid. Command passed was #{line}" unless line.match?(PLACE_REGEX)

        do_placement_command(line)
      else
        raise ReadError, 'Command is not allowed' unless COMMANDS.include?(line.downcase)

        do_default_command
      end
    end

    private

    def do_placement_command(line)
      matches = line.match(PLACE_REGEX)

      Robot.new(matches[2], matches[3], matches[4])
    rescue Robot::InvalidArgument => e
      raise BotArgumentError, e
    end

    def do_default_command(line)
    end
  end
end
