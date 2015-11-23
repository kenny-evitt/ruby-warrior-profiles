class MockRubyWarriorSpace

  # Class methods

  def self.new_really_empty_space
    MockRubyWarriorSpace.new(true, false, false, false, false, false, false)
  end


  ##
  # Initializes a new instance.

  def initialize(is_empty, has_stairs, has_enemy, has_captive, has_wall, is_ticking, has_golem)
    @is_empty = is_empty
    @has_stairs = has_stairs
    @has_enemy = has_enemy
    @has_captive = has_captive
    @has_wall = has_wall
    @has_bomb = is_ticking
    @has_golem = has_golem
  end


  # Instance methods

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

  def ticking?
    @has_bomb
  end

  def wall?
    @has_wall
  end
end
