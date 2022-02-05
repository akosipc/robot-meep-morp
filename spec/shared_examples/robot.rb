# frozen_string_literal: true

require_relative '../../lib/robot'

RSpec.shared_examples 'a robot changing orientation' do |starting_orientation, change, expected_orientation|
  let(:robot) { Robot.new(0, 0, starting_orientation) }

  it "changes the orientation of the robot - `#{starting_orientation}` => `#{expected_orientation}`" do
    robot.send(change)

    expect(robot.orientation).to eq expected_orientation
  end
end

RSpec.shared_examples 'a robot moving' do |initial_vector, expected_vector|
  let(:robot) { Robot.new(initial_vector[0], initial_vector[1], initial_vector[2]) }

  it 'changes the vector of this robot' do
    robot.move

    expect(robot.x).to eq expected_vector[0]
    expect(robot.y).to eq expected_vector[1]
    expect(robot.orientation).to eq expected_vector[2]
  end
end
