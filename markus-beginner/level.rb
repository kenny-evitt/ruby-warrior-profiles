require "space.rb"

##
# This class represents a Ruby Warrior level; particularly its spaces.

class Level

  # Initialization method
  def initialize
    @current_space_index = 0
    @spaces = {@current_space_index => Space.new}
  end

  def update(space_left, space_right)

  end
end
