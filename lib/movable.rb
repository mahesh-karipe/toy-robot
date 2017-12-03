class InvalidCommand < Exception; end
module Movable

  NORTH, EAST, SOUTH, WEST = :NORTH, :EAST, :SOUTH, :WEST
  DIRECTIONS = [NORTH, EAST, SOUTH, WEST]

  attr_reader :x, :y, :direction, :table_top

  def initialize(table_top)
    @table_top = table_top
  end

  def place(x, y, direction)
    raise InvalidCommand, "direction should be one of #{DIRECTIONS.join(', ')}" unless
      DIRECTIONS.include?(direction.upcase.to_sym)

    raise InvalidCommand unless table_top.valid_position?(x, y)
    @x, @y, @direction = x, y, direction
  end

  def move(steps=1)
    dx, dy = case direction
               when NORTH
                 [0, +steps]
               when EAST
                 [+steps, 0]
               when SOUTH
                 [0, -steps]
               when WEST
                 [-steps, 0]
             end

    new_x, new_y = x + dx, y + dy
    raise InvalidCommand unless table_top.valid_position?(new_x, new_y)

    @x, @y = new_x, new_y
  end

  def left
    @direction = DIRECTIONS[(DIRECTIONS.index(direction) - 1) % DIRECTIONS.length]
  end

  def right
    @direction = DIRECTIONS[(DIRECTIONS.index(direction) + 1) % DIRECTIONS.length]
  end

  def report
    "#{x},#{y},#{direction}"
  end
end
