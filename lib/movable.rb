class InvalidCommand < Exception; end
module Movable

  NORTH, EAST, SOUTH, WEST = 'NORTH', 'EAST', 'SOUTH', 'WEST'
  DIRECTIONS = [NORTH, EAST, SOUTH, WEST]

  attr_reader :x, :y, :direction, :table_top

  def initialize(table_top, logger)
    @table_top, @logger, @placed = table_top, logger, false
  end

  def place(x, y, direction)
    raise InvalidCommand, "direction should be one of #{DIRECTIONS.join(', ')}" unless
      DIRECTIONS.include?(direction.strip.upcase)

    x , y = Integer(x), Integer(y) rescue raise InvalidCommand
    raise InvalidCommand unless table_top.valid_position?(x, y)

    @x, @y, @direction, @placed = x, y, direction, true
  end

  def move(steps=1)
    raise InvalidCommand unless @placed

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
    raise InvalidCommand unless @placed

    @direction = DIRECTIONS[(DIRECTIONS.index(direction) - 1) % DIRECTIONS.length]
  end

  def right
    raise InvalidCommand unless @placed

    @direction = DIRECTIONS[(DIRECTIONS.index(direction) + 1) % DIRECTIONS.length]
  end

  def report
    raise InvalidCommand unless @placed

    @logger.info "#{x},#{y},#{direction}"
  end

  def method_missing(method, *args, &block)
    raise InvalidCommand, "Unknown command #{method}"
  end
end
