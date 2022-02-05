# frozen_string_literal: true

require_relative '../lib/commander'

RSpec.describe Commander, type: :class do
  let!(:subject) { described_class.new }

  describe '.read_command' do
    it 'raises an error when nil or empty string is passed' do
      expect do
        subject.read_command('')
      end.to raise_error(Commander::ReadError)
    end

    it 'raises an error when the line is one of the commands' do
      expect do
        subject.read_command('NEGATE')
      end.to raise_error(Commander::ReadError)
    end

    it 'responds properly when given PLACE command' do
      expect(subject.read_command('PLACE 0,0,NORTH')).to be_instance_of Robot
      expect(subject.read_command('pLaCe 2,3,wEsT')).to be_instance_of Robot

      expect do
        subject.read_command('pLaCE 7,7,North')
      end.to raise_error(Commander::ReadError)

      expect do
        subject.read_command('pLaCE 0,0,Bacon')
      end.to raise_error(Commander::ReadError)

      expect do
        subject.read_command('plllaaacccceeee 3,3,right')
      end.to raise_error(Commander::ReadError)
    end

    context 'without a `PLACE` command preceeding' do
      it 'responds to `MOVE` command' do
        expect do
          subject.read_command('move')
        end.to raise_error(Commander::MissingRobotError)
      end

      it 'responds to `LEFT` command' do
        expect do
          subject.read_command('left')
        end.to raise_error(Commander::MissingRobotError)
      end
      it 'responds to `RIGHT` command' do
        expect do
          subject.read_command('right')
        end.to raise_error(Commander::MissingRobotError)
      end

      it 'responds to `REPORT` command' do
        expect do
          subject.read_command('report')
        end.to raise_error(Commander::MissingRobotError)
      end
    end

    context 'with a `PLACE` command preceeding' do
      before { subject.read_command('PLACE 0,0,NORTH') }

      it 'responds to `MOVE` command' do
        subject.read_command('move')

        expect(subject.robot.y).to eq 1
        expect(subject.robot.x).to eq 0
        expect(subject.robot.orientation).to eq 'north'
      end

      it 'responds to `LEFT` command' do
        subject.read_command('left')

        expect(subject.robot.y).to eq 0
        expect(subject.robot.x).to eq 0
        expect(subject.robot.orientation).to eq 'west'
      end

      it 'responds to `RIGHT` command' do
        subject.read_command('right')

        expect(subject.robot.y).to eq 0
        expect(subject.robot.x).to eq 0
        expect(subject.robot.orientation).to eq 'east'
      end

      it 'responds to `REPORT` command' do
        expect(subject.read_command('report')).to eq '0, 0, NORTH'
      end
    end
  end
end
