class Player
  MIN_TOTAL_ATTACKING_DAMAGE_SLUDGE = 6

  def initialize
    @health_last_turn = nil
  end

  def was_attacked(warrior)
    warrior.health < (@health_last_turn || 0)
  end

  def play_turn(warrior)
    if warrior.health < (MIN_TOTAL_ATTACKING_DAMAGE_SLUDGE + 1) && !was_attacked(warrior)
      warrior.rest!
    elsif warrior.feel.empty?
      warrior.walk!
    else
      warrior.attack!
    end

    @health_last_turn = warrior.health
  end
end
