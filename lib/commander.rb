# frozen_string_literal: true

require_relative './robot'

class Commander
  class ReadError < StandardError; end
  class BotArgumentError < StandardError; end
  class MissingRobotError < StandardError; end

  COMMANDS = %w[move left right report].freeze
  PLACE_REGEX = /(?i)(place) ([0-4]),([0-4]),(north|west|south|east)/

  attr_reader :robot

  def initialize(reporting = false)
    @reporting = reporting
  end

  def read_command(line)
    raise ReadError, 'No argument was sent' if line.nil? || line.empty?

    if line.downcase.include?('place')
      raise ReadError, "Place command is not valid. Command passed was #{line}" unless line.match?(PLACE_REGEX)

      do_placement_command(line)
    else
      raise ReadError, 'Command is not allowed' unless COMMANDS.include?(line.downcase)

      do_default_command(line.downcase)
    end
  end

  private

  def do_placement_command(line)
    matches = line.match(PLACE_REGEX)

    @robot = Robot.new(matches[2], matches[3], matches[4])
  rescue Robot::InvalidArgument => e
    raise BotArgumentError, e
  end

  def do_default_command(line)
    raise MissingRobotError, "Cannot execute command #{line}. Current robot is missing. Please use a `PLACE` command first" if @robot.nil?

    if line.downcase == 'report' && @reporting
      puts @robot.report
    else
      @robot.send(line)
    end
  end
end
