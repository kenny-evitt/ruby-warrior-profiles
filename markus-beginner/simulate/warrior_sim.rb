class WarriorSim
  INITIAL_HP = 20

  def initialize(level)
    @level = level
    @hp = INITIAL_HP
  end

  def feel
    @level.warrior_right_space
  end

  def walk!
    @level.try_warrior_walk!
  end

  def hp
    @hp
  end
end