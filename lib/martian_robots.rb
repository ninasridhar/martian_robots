require 'pry'
require 'grid'
require 'robot'

class MartianRobots
  def self.initialize
    welcome_message =
      "
      Please indicate the size of your world and the starting postion and move commands of each robot.
      Please use the format below, leaving a empty line after each robot, ending with a tab.

      5 3
      1 1 E
      RFRFRFRF

      3 2 N
      FRRFLLFFRRFLL

      0 3 W
      LLFFFLFLFL
      "
    puts welcome_message
    response = gets("\t\n")
    output = parse_instructions(response)
  end

  def self.parse_instructions(response)
    split_response = response.split("\n")

    # split_response[0] are the grid bounds
    bounds = split_response.shift
    grid = Grid.new(bounds)

    # Split response into batches of size 3 to include empty string
    robots = split_response.each_slice(3).to_a

    robots.each do |robot_details|
      # robot_details[0] is the starting position
      robot = Robot.new(robot_details[0], grid)
      # robot_details[1] are the instruction
      robot.instruct_to_move(robot_details[1])
    end
  end
end
