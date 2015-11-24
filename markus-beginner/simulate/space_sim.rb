##
#

class SpaceSim

  ##
  # Create a space simulator

  def initialize(space_s, has_stairs = nil)
    @is_empty = false
    @has_stairs = has_stairs
    @has_enemy = false
    @has_captive = false
    @has_wall = false
    @has_bomb = false
    @has_golem = false

    @has_warrior = false

    case space_s
    when " "
      if has_stairs
        raise ArgumentError, "A space cannot be both (really) empty and contain stairs"
      end

      @is_empty = true

    when ">"
      if has_stairs == false
        raise ArgumentError, "A space cannot be both stairs and *not* contain stairs"
      end

      @is_empty = true

    when "|"
      if has_stairs
        raise ArgumentError, "A space cannot both contain a wall and stairs"
      end

    when "@"
      @has_warrior = true

    else
      raise ArgumentError, "'#{space_s}' is not a valid (or supported) string representation of a space"
    end
  end

  def empty?
    @is_empty
  end

  def stairs?
    @has_stairs
  end

  def enemy?
    @has_enemy
  end

  def captive?
    @has_captive
  end

  def wall?
    @has_wall
  end

  def ticking?
    @has_bomb
  end

  def golem?
    @has_golem
  end
end
