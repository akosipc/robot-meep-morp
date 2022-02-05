# frozen_string_literal: true

require 'byebug'

class Robot
  class InvalidArgument < StandardError; end

  attr_reader :x, :y, :orientation

  CARDINAL_DIRECTIONS = %w[north east south west].freeze
  ALLOWED_RANGE = (0..4)

  def initialize(x_coor, y_coor, orientation)
    validate_args(x_coor, y_coor, orientation)

    @x = x_coor.to_i
    @y = y_coor.to_i
    @orientation = orientation.downcase
  end

  def report
    "#{@x}, #{@y}, #{@orientation.upcase}"
  end

  def move
    case @orientation.downcase
    when 'north'
      @y = commit_coordinate_change(@y, 1)
    when 'south'
      @y = commit_coordinate_change(@y, -1)
    when 'east'
      @x = commit_coordinate_change(@x, 1)
    when 'west'
      @x = commit_coordinate_change(@x, -1)
    end
  end

  def left
    @orientation = change_orientation(-1)
  end

  def right
    @orientation = change_orientation(1)
  end

  private

  def commit_coordinate_change(planar_coordinate, value)
    planar_coordinate + value if ALLOWED_RANGE === (planar_coordinate + value)
  end

  def validate_args(x_coor, y_coor, orientation)
    unless ALLOWED_RANGE === x_coor.to_i
      raise InvalidArgument, "Invalid value for argument (:x_coor). Value passed is #{x_coor}"
    end
    unless ALLOWED_RANGE === y_coor.to_i
      raise InvalidArgument, "Invalid value for argument (:y_coor). Value passed is #{y_coor}"
    end
    unless CARDINAL_DIRECTIONS.include?(orientation.downcase)
      raise InvalidArgument, "Invalid value for argument (:orientation). Value passed is #{orientation}"
    end

    true
  end

  def change_orientation(marker)
    if CARDINAL_DIRECTIONS.index(@orientation) + marker >= 4
      CARDINAL_DIRECTIONS.at(0)
    else
      CARDINAL_DIRECTIONS.at(CARDINAL_DIRECTIONS.index(@orientation) + marker)
    end
  end
end
