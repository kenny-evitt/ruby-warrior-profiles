require "space_map.rb"


# TODO: Move this into `player.rb`; it's redundant.

class WarriorMind
  # Initialization method
  def initialize
    @current_level_space_index = 0
    @level_spaces = {@current_level_space_index => SpaceMap.new}
  end

  def make_decision!(warrior)
  end
end
