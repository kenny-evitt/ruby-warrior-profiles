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
    @is_backward = true
  end

  def attack!
    if @is_backward
      @current_warrior.attack! :backward
    else
      @current_warrior.attack!
    end
  end

  def can_survive_any_attack?
    health >= Player.min_health_to_survive_attack
  end

  def feel
    if @is_backward
      @current_warrior.feel :backward
    else
      @current_warrior.feel
    end
  end

  def health
    @current_warrior.health
  end

  def rescue!
    if @is_backward
      @current_warrior.rescue! :backward
    else
      @current_warrior.rescue!
    end
  end

  def rest!
    @current_warrior.rest!
  end

  def was_attacked?
    health < (@health_last_turn || 0)
  end

  def walk!
    if @is_backward
      @current_warrior.walk! :backward
    else
      @current_warrior.walk!
    end
  end

  def play_turn(warrior)
    @current_warrior = warrior
    next_space = feel

    if next_space.wall?
      @is_backward = false
    elsif next_space.captive?
      rescue!
    elsif !can_survive_any_attack? && !was_attacked?
      rest!
    elsif next_space.empty?
      walk!
    else
      attack!
    end

    @health_last_turn = warrior.health
  end
end
