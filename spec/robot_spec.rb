# frozen_string_literal: true

require_relative '../lib/robot'
require_relative './shared_examples/robot'

RSpec.describe Robot, type: :class do
  describe '#initialize' do
    it 'returns an error when x is not within the bounded parameters' do
      expect do
        described_class.new(7, 0, 'north')
      end.to raise_error(Robot::InvalidArgument)

      expect do
        described_class.new(-2, 0, 'north')
      end.to raise_error(Robot::InvalidArgument)
    end

    it 'returns an error when y is not within the bounded parameters' do
      expect do
        described_class.new(0, 6, 'north')
      end.to raise_error(Robot::InvalidArgument)

      expect do
        described_class.new(0, 5, 'north')
      end.to raise_error(Robot::InvalidArgument)
    end

    it 'returns an error when orientation is not within the array of cardinal directions' do
      expect do
        described_class.new(0, 0, 'neither')
      end.to raise_error(Robot::InvalidArgument)
    end
  end

  describe '#report' do
    let!(:robot) { described_class.new(0, 0, 'North') }

    it 'returns the current position in the board' do
      expect(robot.report).to eq "#{robot.x}, #{robot.y}, #{robot.orientation.upcase}"
    end
  end

  describe '#move' do
    context 'valid inputs' do
      it_behaves_like 'a robot moving', [0, 0, 'north'], [0, 1, 'north']
      it_behaves_like 'a robot moving', [0, 4, 'south'], [0, 3, 'south']
      it_behaves_like 'a robot moving', [0, 0, 'east'], [1, 0, 'east']
      it_behaves_like 'a robot moving', [4, 0, 'west'], [3, 0, 'west']
    end

    context 'invalid inputs for x coords' do
      let(:robot) { described_class.new(0, 0, 'WEST') }

      it 'ignores the change if the input is invalid' do
        expect(robot.x).to eq 0
        expect(robot.y).to eq 0
      end
    end

    context 'invalid inputs for y coords' do
      let(:robot) { described_class.new(0, 4, 'NORTH') }

      it 'ignores the change if the input is invalid' do
        expect(robot.x).to eq 0
        expect(robot.y).to eq 4
      end
    end
  end

  describe '#left' do
    it_behaves_like 'a robot changing orientation', 'north', :left, 'west'
    it_behaves_like 'a robot changing orientation', 'west', :left, 'south'
    it_behaves_like 'a robot changing orientation', 'south', :left, 'east'
    it_behaves_like 'a robot changing orientation', 'east', :left, 'north'
  end

  describe '#right' do
    it_behaves_like 'a robot changing orientation', 'north', :right, 'east'
    it_behaves_like 'a robot changing orientation', 'east', :right, 'south'
    it_behaves_like 'a robot changing orientation', 'south', :right, 'west'
    it_behaves_like 'a robot changing orientation', 'west', :right, 'north'
  end
end
