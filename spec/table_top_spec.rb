require 'table_top'

describe TableTop do

  describe '#initialize' do
    context 'for valid dimensions' do
      it 'should assign x & y' do
        table_top = TableTop.new(5,5)

        expect(table_top.x).to equal(5)
        expect(table_top.y).to equal(5)
      end
    end

    context 'for invalid dimensions' do
      it 'should raise argument error' do
        expect { TableTop.new(0,0) }.to raise_exception(ArgumentError)
      end
    end
  end

  describe 'valid_postion?' do
    before :all do
      @table_top = TableTop.new(5,5)
    end

    context 'when the position is valid' do
      [[0,0], [0,5], [5,0], [5,5], [2,2]].each do |position|
        it "should return true for (#{position.first}, #{position.last})" do
          expect(@table_top.valid_position?(*position)).to be_truthy
        end
      end
    end

    context 'when the position is invalid' do
      [[-1,0], [0,-1], [-1, -1], [6,6]].each do |position|
        it "should return true for (#{position.first}, #{position.last})" do
          expect(@table_top.valid_position?(*position)).to be_falsey
        end
      end
    end
  end
end
