class TableTop
  attr_reader :x, :y

  def initialize(x=5, y=5)
    raise ArgumentError, 'table dimensions should be greater than 0' if x.to_i <= 0 || y.to_i <=0
    @x, @y = x, y
  end

  def valid_position?(x,y)
    valid_x?(x) && valid_y?(y)
  end

  private

  %w(x y).each do |t_axis|
    define_method "valid_#{t_axis}?" do |axis|
      (0..self.send(t_axis.to_sym)).include?(axis)
    end
  end
end
