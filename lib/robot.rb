class Robot

  TURN_LEFT = {
    N: 'W',
    W: 'S',
    S: 'E',
    E: 'N'
  }

  TURN_RIGHT = {
    N: 'E',
    E: 'S',
    S: 'W',
    W: 'N'
  }

  attr_accessor :x, :y, :direction, :grid, :direction, :lost

  def initialize(details, grid)
    split_details = details.split(' ')
    @x = split_details[0].to_i
    @y = split_details[1].to_i
    @direction = split_details[2]
    @grid = grid
    @lost = false
  end

  def instruct_to_move(instructions)
    instructions.split('').each do |movement|
      return if @lost
      case movement
      when 'L'
        self.turn_left
      when 'R'
        self.turn_right
      when 'F'
        self.move_forward
      end
      check_if_lost
    end
  end

  def turn_left
    @direction = TURN_LEFT[@direction.to_sym]
  end

  def turn_right
    @direction = TURN_RIGHT[@direction.to_sym]
  end

  def move_forward
    return if @lost || @grid.is_protected?([@x, @y, @direction])
    case @direction
    when 'N'
      @y += 1
    when 'E'
      @x += 1
    when 'S'
      @y -= 1
    when 'W'
      @x -= 1
    end
  end

  def check_if_lost
    x_out_of_bounds = 0 > @x || @grid.x_bound < @x
    y_out_of_bounds = 0 > @y || @grid.y_bound < @y
    return unless x_out_of_bounds || y_out_of_bounds
    @lost = true
    get_and_protect_lost_position
  end

  def get_and_protect_lost_position
    @x = 0 if 0 > @x
    @x = @grid.x_bound if @grid.x_bound < @x
    @y = 0 if 0 > @y
    @y = @grid.y_bound if @grid.y_bound < @y

    @grid.protect_bound([@x, @y, @direction])
  end

  def get_output
    output = "#{@x} #{@y} #{direction}"
    return output unless @lost
    output + " LOST"
  end
end