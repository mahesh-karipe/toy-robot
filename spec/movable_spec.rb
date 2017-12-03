require 'movable'

describe Movable do
  before :all do
    movable_class = Class.new { include Movable }
    table_top = TableTop.new
    @obj = movable_class.new(table_top)
  end

  describe '#place' do
    context 'when called with valid arguments' do
      before :all do
        @obj.place(1,2,:NORTH)
      end

      it 'should assign the right x position' do
        expect(@obj.x).to eq(1)
      end

      it 'should assign the right y position' do
        expect(@obj.y).to eq(2)
      end

      it 'should assign the right direction' do
        expect(@obj.direction).to eq(:NORTH)
      end
    end

    context 'when called with invalid arguments' do
      it 'should raise InvalidCommand exception for invalid x & y' do
        allow(@obj.table_top).to receive(:valid_position?).and_return(false)

        expect { @obj.place(6, 5, :NORTH) } .to raise_exception(InvalidCommand)
        expect { @obj.place(5, 6, :NORTH) } .to raise_exception(InvalidCommand)
      end

      it 'should raise InvalidCommand exception for invalid direction' do
        expect { @obj.place(1, 1, :INVALID) } .to raise_exception(InvalidCommand)
      end
    end
  end

  describe '#move' do
    context 'when it is an invalid move' do
      it 'should raise InvalidCommand exception' do
        @obj.place(1,1,:NORTH)

        allow(@obj.table_top).to receive(:valid_position?).and_return(false)
        expect { @obj.move }.to raise_exception(InvalidCommand)
      end
    end

    context 'when current direction is NORTH' do
      it 'should move 1 step north' do
        @obj.place(1,1,:NORTH)
        @obj.move

        expect(@obj.y).to eq(2)
      end
    end

    context 'when current direction is EAST' do
      it 'should move 1 step east' do
        @obj.place(1,1,:EAST)
        @obj.move

        expect(@obj.x).to eq(2)
      end
    end

    context 'when current direction is WEST' do
      it 'should move 1 step east' do
        @obj.place(1,1,:WEST)
        @obj.move

        expect(@obj.x).to eq(0)
      end
    end

    context 'when current direction is SOUTH' do
      before :all do
        @obj.place(1,1,:SOUTH)
      end

      it 'should move 1 step east' do
        @obj.move
        expect(@obj.y).to eq(0)
      end
    end
  end

  describe '#left' do
    context 'when current direction is NORTH' do
      it 'should turn return WEST' do
        @obj.place(1,1,:NORTH)
        @obj.left

        expect(@obj.direction).to eq(:WEST)
      end
    end

    context 'when current direction is WEST' do
      it 'should turn return SOUTH' do
        @obj.place(1,1,:WEST)
        @obj.left

        expect(@obj.direction).to eq(:SOUTH)
      end
    end

    context 'when current direction is SOUTH' do
      it 'should turn return EAST' do
        @obj.place(1,1,:SOUTH)
        @obj.left

        expect(@obj.direction).to eq(:EAST)
      end
    end

    context 'when current direction is EAST' do
      it 'should turn return NORTH' do
        @obj.place(1,1,:EAST)
        @obj.left

        expect(@obj.direction).to eq(:NORTH)
      end
    end
  end

  describe '#right' do
    context 'when current direction is NORTH' do
      it 'should turn return EAST' do
        @obj.place(1,1,:NORTH)
        @obj.right

        expect(@obj.direction).to eq(:EAST)
      end
    end

    context 'when current direction is WEST' do
      it 'should turn return NORTH' do
        @obj.place(1,1,:WEST)
        @obj.right

        expect(@obj.direction).to eq(:NORTH)
      end
    end

    context 'when current direction is SOUTH' do
      it 'should turn return WEST' do
        @obj.place(1,1,:SOUTH)
        @obj.right

        expect(@obj.direction).to eq(:WEST)
      end
    end

    context 'when current direction is EAST' do
      it 'should turn return SOUTH' do
        @obj.place(1,1,:EAST)
        @obj.right

        expect(@obj.direction).to eq(:SOUTH)
      end
    end
  end

  describe '#report' do
    it 'should report position and direction' do
      allow(@obj).to receive(:x).and_return('x')
      allow(@obj).to receive(:y).and_return('y')
      allow(@obj).to receive(:direction).and_return('dir')

      expect(@obj.report).to eq('x,y,dir')
    end
  end
end
