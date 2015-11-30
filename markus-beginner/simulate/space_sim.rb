require_relative 'sludge_sim'

class SpaceSim

  ##
  # Create a space simulator

  def initialize(index, space_s, has_stairs = nil)
    @index = index

    @is_empty = false
    @has_stairs = has_stairs == true
    @has_enemy = false
    @has_captive = false
    @has_wall = false
    @has_bomb = false
    @has_golem = false

    @has_warrior = false

    case space_s
      when " "
        if has_stairs
          raise ArgumentError, "A space cannot be both (really) empty *and* contain stairs"
        end

        @is_empty = true

      when ">"
        if has_stairs == false
          raise ArgumentError, "A space cannot be both stairs and *not* contain stairs"
        end

        @has_stairs = true
        @is_empty = true

      when "|"
        if has_stairs
          raise ArgumentError, "A space cannot both contain a wall and stairs"
        end

        @has_wall = true

      when "@"
        @has_warrior = true

      when "s"
        @has_enemy = true
        @enemy = SludgeSim.new

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



  def index
    @index
  end

  def enter
    if self.warrior?
      raise "Cannot enter because the warrior is already present"
    else
      @has_warrior = true
      @is_empty = false
    end
  end

  def leave
    if !self.warrior?
      raise "Cannot leave because the warrior is not present"
    else
      @has_warrior = false
      @is_empty = true
    end
  end

  def warrior?
    @has_warrior
  end

  def to_s
    case
      when self.warrior?
        "@"
      #when self.ticking? == true
      #  "B" # ?
      when self.captive? == true
        "C"
      when self.enemy? == true
        @enemy.to_s
      #when self.golem? == true
      #  "G"
      when self.stairs? == true
        ">"
      when self.wall? == true
        "|"
      when self.empty? == true
        " "
      else
        raise "`SpaceSim` object cannot be converted to a string"
    end
  end
end
