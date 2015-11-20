class Player
  MIN_TOTAL_ATTACKING_DAMAGE_SLUDGE = 6
  MIN_TOTAL_ATTACKING_DAMAGE_THICK_SLUDGE = 12
  MIN_TOTAL_ATTACKING_DAMAGE_ARCHER = 6

  def self.min_health_to_survive_attack
    [
      MIN_TOTAL_ATTACKING_DAMAGE_SLUDGE,
      MIN_TOTAL_ATTACKING_DAMAGE_THICK_SLUDGE,
      MIN_TOTAL_ATTACKING_DAMAGE_ARCHER
    ].max + 1
  end

  def initialize
    @health_last_turn = nil
  end

  def was_attacked(warrior)
    warrior.health < (@health_last_turn || 0)
  end

  def play_turn(warrior)
    if warrior.health < Player.min_health_to_survive_attack && !was_attacked(warrior)
      warrior.rest!
    elsif warrior.feel.empty?
      warrior.walk!
    else
      warrior.attack!
    end

    @health_last_turn = warrior.health
  end
end
