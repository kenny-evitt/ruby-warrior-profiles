##
# This class represents a single space in a Ruby Warrior level.

class Space
  # Initialization method
  def initialize(index, ruby_warrior_space, args = nil)
    @index = index

    if ruby_warrior_space.nil?
      @is_empty = :maybe
      @has_stairs = :maybe
      @has_enemy = :maybe
      @has_captive = :maybe
      @has_wall = :maybe
      @has_bomb = :maybe
      @has_golem = :maybe
    else
      update(ruby_warrior_space)
    end

    # `!!x` coerces `x` to a boolean.
    @has_warrior = !args.nil? && !!args[:warrior?]
    @is_start = !args.nil? && !!args[:start?]
  end


  def index
    @index
  end


  def bomb?
    @has_bomb
  end

  def captive?
    @has_captive
  end

  def empty?
    @is_empty
  end

  def enemy?
    @has_enemy
  end

  def golem?
    @has_golem
  end

  def stairs?
    @has_stairs
  end

  def start?
    @is_start
  end

  def wall?
    @has_wall
  end

  def warrior?
    @has_warrior
  end


  def enter!
    @has_warrior = true
  end

  def leave!
    @has_warrior = false
  end


  def to_s
    case
    when self.warrior?
      "@"
    when self.start?
      "*"

    when self.bomb? == true
      "B"
    when self.captive? == true
      "C"
    when self.enemy? == true
      "E"
    when self.golem? == true
      "G"
    when self.stairs? == true
      ">"
    when self.wall? == true
      "|"

    when self.empty? == true
      " "
    else
      "?"
    end
  end

  def update(ruby_warrior_space, args = nil)
    @is_empty = ruby_warrior_space.empty? && !ruby_warrior_space.stairs?
    @has_stairs = ruby_warrior_space.stairs?
    @has_enemy = ruby_warrior_space.enemy?
    @has_captive = ruby_warrior_space.captive?
    @has_wall = ruby_warrior_space.wall?
    @has_bomb = ruby_warrior_space.ticking?
    @has_golem = ruby_warrior_space.golem?

    # `!!x` coerces `x` to a boolean.
    @has_warrior = !args.nil? && !!args[:warrior?]
  end
end
