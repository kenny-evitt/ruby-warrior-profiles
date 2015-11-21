##
# This class represents a single space in a Ruby Warrior level.

class Space
  # Initialization method
  def initialize(ruby_warrior_space)
    @is_empty = ruby_warrior_space.nil? || (ruby_warrior_space.empty? && !ruby_warrior_space.stairs?)
  end

  def empty?
    @is_empty
  end
end
