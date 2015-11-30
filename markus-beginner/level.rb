require_relative "space"

##
# This class represents a Ruby Warrior level; particularly its spaces.

class Level

  def self.to_s(spaces)
    reduce_spaces_to_s(spaces) { |space| space.to_s }
  end

  def self.reduce_spaces_to_s(spaces)
    spaces
    .to_a
    .sort
    .map { |index_space_key_value_array| index_space_key_value_array[1] }
    .reduce("") { |s, space| s << yield(space) }
  end

  # Initialization method

  def initialize
    @current_space_index = 0

    @spaces =
      {
        @current_space_index => Space.new(@current_space_index, nil, :warrior? => true, :start? => true),
        left_space_index => Space.new(left_space_index, nil),
        right_space_index => Space.new(right_space_index, nil)
      }
  end


  # Instance methods

  def current_space
    @spaces[@current_space_index]
  end

  def current_space_index
    @current_space_index
  end


  def left_space
    @spaces[left_space_index]
  end

  def left_space=(space)
    @spaces[left_space_index] = space
  end

  def left_space_index
    @current_space_index - 1
  end


  def lefter_space
    @spaces[lefter_space_index]
  end

  def lefter_space=(space)
    @spaces[lefter_space_index] = space
  end

  def lefter_space_index
    @current_space_index - 2
  end


  def right_space
    @spaces[right_space_index]
  end

  def right_space=(space)
    @spaces[right_space_index] = space
  end

  def right_space_index
    @current_space_index + 1
  end


  def righter_space
    @spaces[righter_space_index]
  end

  def righter_space=(space)
    @spaces[righter_space_index] = space
  end

  def righter_space_index
    @current_space_index + 2
  end


  def find_next_enemy(direction)
    next_spaces = case direction
    when :left
      @spaces
      .select { |index, space| index < @current_space_index }
      .to_a
      .sort { |a, b| b <=> a }
    when :right
      @spaces
      .select { |index, space| index > @current_space_index }
      .to_a
      .sort
    else
      raise ArgumentError, "`direction` must be either `:left` or `:right`"
    end

    next_spaces
    .map { |index_space_key_value_array| index_space_key_value_array[1] }
    .select { |space| space.enemy? }
    .first
  end

  def next_space_towards_target(target_space)
    if target_space.index == @current_space_index
      nil
    elsif target_space.index > @current_space_index
      right_space
    else
      left_space
    end
  end


  ##
  # Builds a string representing the known spaces.
  #
  # Accepts a block with a space argument that should return a string representation of the supplied space.

  def reduce_spaces_to_s
    Level.reduce_spaces_to_s(@spaces, &Proc.new)
  end


  def spaces
    @spaces
  end


  ##
  # Convert the level to a string representing the known spaces.
  #--
  # TODO: Add lines to verbose output for different types of info.
  #++

  def to_s(verbose = false)
    s = reduce_spaces_to_s { |space| space.to_s }

    if !verbose
      s
    else
      s = "" + s
    end
  end


  def update(ruby_warrior_space_left, ruby_warrior_space_right)
    if self.left_space.nil?
      self.left_space = Space.new(left_space_index, ruby_warrior_space_left)
    else
      self.left_space.update(ruby_warrior_space_left)

      # If the left space isn't a wall and there isn't already a 'lefter' space, add it.
      if !self.left_space.wall? && self.lefter_space.nil?
        self.lefter_space = Space.new(lefter_space_index, nil)
      end
    end

    if self.right_space.nil?
      self.right_space = Space.new(right_space_index, ruby_warrior_space_right)
    else
      self.right_space.update(ruby_warrior_space_right)

      # If the right space isn't a wall and there isn't already a 'righter' space, add it.
      if !self.right_space.wall? && self.righter_space.nil?
        self.righter_space = Space.new(righter_space_index, nil)
      end
    end
  end

  def walk!(direction)
    case direction
    when :left
      self.current_space.leave!
      self.left_space.enter!
      @current_space_index = left_space_index
    when :right
      self.current_space.leave!
      self.right_space.enter!
      @current_space_index = right_space_index
    else
      raise ArgumentError, "`direction` must be either `:left` or `:right`"
    end
  end
end
