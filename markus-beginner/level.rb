require "space.rb"

##
# This class represents a Ruby Warrior level; particularly its spaces.

class Level

  # Initialization method

  def initialize
    @current_space_index = 0
    @spaces = {@current_space_index => Space.new(nil)}
  end


  # Instance methods

  def left_space
    @spaces[left_space_index]
  end

  def left_space=(ruby_warrior_space)
    @spaces[left_space_index]
  end

  def left_space_index
    @current_space_index - 1
  end

  def right_space
    @spaces[right_space_index]
  end

  def right_space=(ruby_warrior_space)
    @spaces[right_space_index]
  end

  def right_space_index
    @current_space_index + 1
  end

  def update(ruby_warrior_space_left, ruby_warrior_space_right)
    if left_space.nil?
      self.left_space = Space.new(ruby_warrior_space_left)
    else
      # TODO: Update existing space.
    end

    if right_space.nil?
      self.right_space = Space.new(ruby_warrior_space_right)
    else
      # TODO: Update existing space.
    end
  end
end
