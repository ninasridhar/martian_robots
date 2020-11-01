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

    context 'if not lost' do
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

    context 'if robot gets lost' do
      let(:robot) { Robot.new('3 2 N', grid) }
      let(:instructions) { 'FRRFLLFFRRFLL' }
      let(:grid) { Grid.new('5 3') }

      it 'applies the instructions correctly' do
        subject
        expect(robot.x).to eq(3)
        expect(robot.y).to eq(3)
        expect(robot.direction).to eq('N')
        expect(robot.grid).to eq(grid)
        expect(robot.lost).to be_truthy
      end
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

    context 'when the robot is lost' do
      let(:robot) { Robot.new('10 10 E', grid) }

      before do
        robot.lost = true
      end

      it 'does nothing' do
        expect{ subject }.not_to change { robot.x }
        expect{ subject }.not_to change { robot.y }
      end
    end

    context 'when the position is protected' do
      let(:robot) { Robot.new('10 10 E', grid) }

      before do
        allow(grid).to receive(:is_protected?).and_return(true)
      end

      it 'does nothing' do
        expect{ subject }.not_to change { robot.x }
        expect{ subject }.not_to change { robot.y }
      end
    end
  end

  describe '#check_if_lost' do
    subject(:subject) { robot.check_if_lost }
    let(:grid) { Grid.new('3 3') }

    context 'when the robot within the grid' do
      let(:robot) { Robot.new('1 2 E', grid) }

      it 'is not lost' do
        subject
        expect(robot.lost).to be_falsey
      end
    end

    context 'when the robot outside the grid on the x axis' do
      context 'x coordinate is lower than 0' do
        let(:robot) { Robot.new('-1 2 E', grid) }

        it 'is lost' do
          subject
          expect(robot.lost).to be_truthy
        end
      end

      context 'x coordinate is greater than bound' do
        let(:robot) { Robot.new('5 2 E', grid) }

        it 'is lost' do
          subject
          expect(robot.lost).to be_truthy
        end
      end
    end

    context 'when the robot outside the grid on the y axis' do
      context 'y coordinate is lower than 0' do
        let(:robot) { Robot.new('1 -2 E', grid) }

        it 'is lost' do
          subject
          expect(robot.lost).to be_truthy
        end
      end

      context 'y coordinate is greater than bound' do
        let(:robot) { Robot.new('2 5 E', grid) }

        it 'is lost' do
          subject
          expect(robot.lost).to be_truthy
        end
      end
    end
  end

  describe '#get_and_protect_lost_position' do
    subject(:subject) { robot.get_and_protect_lost_position }

    context 'if robot gets lost' do
      let(:robot) { Robot.new('7 2 N', grid) }
      let(:instructions) { 'FRRFLLFFRRFLLFFF' }
      let(:grid) { Grid.new('5 3') }

      it 'saves the coordinates correctly' do
        subject
        expect(robot.x).to eq(5)
        expect(robot.y).to eq(2)
      end

      it 'makes a call to protect the boundary' do
        allow(grid).to receive(:protect_bound)
        subject
        expect(grid).to have_received(:protect_bound).with([5, 2, 'N'])
      end
    end
  end

  describe '#get_output' do
    subject(:subject) { robot.get_output}
    let(:robot) { Robot.new('7 2 N', grid) }

    context 'if lost robot' do
      before do
        robot.lost = true
      end

      it 'shows the correct output' do
        expect(subject).to eq('7 2 N LOST')
      end
    end

    context 'if not lost' do
      it 'shows the correct output' do
        expect(subject).to eq('7 2 N')
      end
    end
  end
end