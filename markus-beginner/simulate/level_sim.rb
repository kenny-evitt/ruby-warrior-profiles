require_relative 'space_sim'

class LevelSim

  ##
  # Initialize a new instance.
  def initialize(level_s, stairs_index = nil)
    @spaces = []

    level_s.split(//).each_with_index do |space_s, index|
      has_stairs = stairs_index == index
      @spaces << SpaceSim(space_s, has_stairs)
    end
  end
end
