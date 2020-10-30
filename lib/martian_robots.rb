require 'pry'

module MartianRobots
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
    parse_instructions(response)
  end

  def self.parse_instructions(response)
    split_response = response.split("\n")
  end
end
