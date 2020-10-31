require 'robot'
require 'grid'

RSpec.describe Robot do
  let(:grid) { Grid.new('10 20') }

  describe '#new' do
    subject(:subject) { described_class.new(details, grid) }

    let(:grid) do
      Grid.new('10 20')
    end
    let(:details) { '1 1 E' }

    it 'produces the correct output' do
      expect(subject.x).to eq(1)
      expect(subject.y).to eq(1)
      expect(subject.direction).to eq('E')
      expect(subject.grid).to eq(grid)
      expect(subject.lost).to be_falsey
    end
  end

  describe '#instruct_to_move' do
    subject(:subject) { robot.instruct_to_move(instructions) }

    let(:robot) { Robot.new('1 2 N', grid) }
    let(:instructions) { 'FFFRF' }

    it 'applies the instructions correctly' do
      subject
      expect(robot.x).to eq(2)
      expect(robot.y).to eq(5)
      expect(robot.direction).to eq('E')
      expect(robot.grid).to eq(grid)
      expect(robot.lost).to be_falsey
    end
  end

  describe '#turn_left' do
    subject(:subject) { robot.turn_left }

    context 'when the robot is facing north' do
      let(:robot) { Robot.new('1 2 N', grid) }

      it 'turns to face W' do
        subject
        expect(robot.direction).to eq('W')
      end
    end

    context 'when the robot is facing west' do
      let(:robot) { Robot.new('1 2 W', grid) }

      it 'turns to face S' do
        subject
        expect(robot.direction).to eq('S')
      end
    end

    context 'when the robot is facing south' do
      let(:robot) { Robot.new('1 2 S', grid) }

      it 'turns to face E' do
        subject
        expect(robot.direction).to eq('E')
      end
    end

    context 'when the robot is facing east' do
      let(:robot) { Robot.new('1 2 E', grid) }

      it 'turns to face N' do
        subject
        expect(robot.direction).to eq('N')
      end
    end
  end

  describe '#turn_right' do
    subject(:subject) { robot.turn_right }

    context 'when the robot is facing north' do
      let(:robot) { Robot.new('1 2 N', grid) }

      it 'turns to face E' do
        subject
        expect(robot.direction).to eq('E')
      end
    end

    context 'when the robot is facing west' do
      let(:robot) { Robot.new('1 2 W', grid) }

      it 'turns to face N' do
        subject
        expect(robot.direction).to eq('N')
      end
    end

    context 'when the robot is facing south' do
      let(:robot) { Robot.new('1 2 S', grid) }

      it 'turns to face W' do
        subject
        expect(robot.direction).to eq('W')
      end
    end

    context 'when the robot is facing east' do
      let(:robot) { Robot.new('1 2 E', grid) }

      it 'turns to face S' do
        subject
        expect(robot.direction).to eq('S')
      end
    end
  end

  describe '#move_forwards' do
    subject(:subject) { robot.move_forward }

    context 'when the robot is facing north' do
      let(:robot) { Robot.new('1 2 N', grid) }

      it 'y axis increments by 1' do
        subject
        expect(robot.y).to eq(3)
      end
    end

    context 'when the robot is facing west' do
      let(:robot) { Robot.new('1 2 W', grid) }

      it 'x axis decrements by 1' do
        subject
        expect(robot.x).to eq(0)
      end
    end

    context 'when the robot is facing south' do
      let(:robot) { Robot.new('1 2 S', grid) }

      it 'y axis decrements by 1' do
        subject
        expect(robot.y).to eq(1)
      end
    end

    context 'when the robot is facing east' do
      let(:robot) { Robot.new('1 2 E', grid) }

      it 'x axis increments by 1' do
        subject
        expect(robot.x).to eq(2)
      end
    end
  end
end