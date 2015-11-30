require_relative 'space_sim'
require_relative 'warrior_sim'
require_relative '../level'

class LevelSim

  ##
  # Initialize a new instance.

  def initialize(level_s, stairs_index = nil)
    @spaces = []
    @warrior_space_index = nil

    level_s.split(//).each_with_index do |space_s, index|
      has_stairs = stairs_index == index

      if has_stairs
        space = SpaceSim.new(index, space_s, has_stairs)
      else
        space = SpaceSim.new(index, space_s)
      end

      if space.warrior?
        if @warrior_space_index.nil?
          @warrior_space_index = index
        else
          raise ArgumentError, "A level cannot contain multiple warriors"
        end
      end

      @spaces << space
    end

    @warrior = WarriorSim.new(self)
  end

  ##
  # Play a turn.
  # Returns true if the level has been passed; false otherwise.

  def play_turn!(player)
    player.play_turn(@warrior)

    warrior_space.stairs? # The level is passed if the warrior reaches the stairs
  end

  def to_s
    @spaces
    .reduce("") { |s, space| s << space.to_s }
  end

  def warrior
    @warrior
  end

  def warrior_space
    @spaces[@warrior_space_index]
  end

  def warrior_right_space
    @spaces[@warrior_space_index + 1]
  end

  def try_warrior_walk!
    if warrior_right_space.empty?
      self.warrior_space.leave
      self.warrior_right_space.enter
      @warrior_space_index += 1
    end
  end
end
