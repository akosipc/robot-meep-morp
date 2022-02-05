# frozen_string_literal: true

require_relative '../../lib/commander'

RSpec.describe 'Placing and moving the robot' do
  let!(:commander) { Commander.new }
  let!(:commands) { [] }

  before { commands.each { |c| commander.read_command(c) } }

  describe '1st given scenario' do
    let!(:commands) { ['place 0,0,north', 'move', 'report'] }

    it 'moves and reports the position of the robot' do
      expect(commander.robot.x).to eq 0
      expect(commander.robot.y).to eq 1
      expect(commander.robot.orientation).to eq 'north'
    end
  end

  describe '2nd given scenario' do
    let!(:commands) { ['place 0,0,north', 'left', 'report'] }

    it 'moves and changes the position of the robot' do
      expect(commander.robot.x).to eq 0
      expect(commander.robot.y).to eq 0
      expect(commander.robot.orientation).to eq 'west'
    end
  end

  describe '3rd given scenario' do
    let!(:commands) { ['place 1,2,east', 'move', 'move', 'left', 'move', 'report'] }

    it 'moves and changes the position of the robot' do
      expect(commander.robot.x).to eq 3
      expect(commander.robot.y).to eq 3
      expect(commander.robot.orientation).to eq 'north'
    end
  end

  describe '1st falling off scenario' do
    let!(:commands) { ['place 3,3,north', 'move', 'move', 'move'] }

    it 'moves the robot' do
      expect(commander.robot.x).to eq 3
      expect(commander.robot.y).to eq 4
      expect(commander.robot.orientation).to eq 'north'
    end
  end

  describe '2nd falling off scenario' do
    let!(:commands) { ['place 0,0,south', 'move', 'move', 'move'] }

    it 'keeps the robot from falling' do
      expect(commander.robot.x).to eq 0
      expect(commander.robot.y).to eq 0
      expect(commander.robot.orientation).to eq 'south'
    end
  end

  describe 'robot replacement scenario' do
    let!(:commands) { ['place 0,0,south', 'move', 'move', 'place 0,1,north', 'move'] }

    it 'destroys the previous robot object and makes a new one' do
      expect(commander.robot.x).to eq 0
      expect(commander.robot.y).to eq 2
      expect(commander.robot.orientation).to eq 'north'
    end
  end
end
