class Robot

  TURN_LEFT = {
    'N': 'W',
    'W': 'S',
    'S': 'E',
    'E': 'N'
  }

  TURN_RIGHT = {
    'N': 'E',
    'E': 'S',
    'S': 'W',
    'W': 'N'
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
      case movement
      when 'L'
        self.turn_left
      when 'R'
        self.turn_right
      when 'F'
        self.move_forward
      end
    end
  end

  def turn_left
    @direction = TURN_LEFT[@direction.to_sym]
  end

  def turn_right
    @direction = TURN_RIGHT[@direction.to_sym]
  end

  def move_forward
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
end