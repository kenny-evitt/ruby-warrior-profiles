require "warrior_mind.rb"


class Player

  # Constants

  MIN_TOTAL_ATTACKING_DAMAGE_SLUDGE = 6
  MIN_TOTAL_ATTACKING_DAMAGE_THICK_SLUDGE = 12
  MIN_TOTAL_ATTACKING_DAMAGE_ARCHER = 6

  MIN_DAMAGE_TO_RETREAT_SLUDGE = 0
  MIN_DAMAGE_TO_RETREAT_THICK_SLUDGE = 0
  MIN_DAMAGE_TO_RETREAT_ARCHER = 6


  # Class methods

  def self.min_health_to_survive_attack
    [
      MIN_TOTAL_ATTACKING_DAMAGE_SLUDGE,
      MIN_TOTAL_ATTACKING_DAMAGE_THICK_SLUDGE,
      MIN_TOTAL_ATTACKING_DAMAGE_ARCHER
    ].max + 1
  end

  def self.min_health_to_survive_retreat
    [
      MIN_DAMAGE_TO_RETREAT_SLUDGE,
      MIN_DAMAGE_TO_RETREAT_THICK_SLUDGE,
      MIN_DAMAGE_TO_RETREAT_ARCHER
    ].max + 1
  end


  # Initialization method

  def initialize
    @health_last_turn = nil
    @is_backward = true
  end


  # Instance methods

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

  def damage_last_turn
    (@health_last_turn || health) - health
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

  def retreat!
    if @is_backward
      @current_warrior.walk!
    else
      @current_warrior.walk! :backward
    end
  end

  def should_retreat?
    was_attacked? && (health - damage_last_turn) < Player.min_health_to_survive_retreat
  end

  def walk!
    if @is_backward
      @current_warrior.walk! :backward
    else
      @current_warrior.walk!
    end
  end

  def was_attacked?
    health < (@health_last_turn || 0)
  end


  # Play-turn method

  def play_turn(warrior)
    @current_warrior = warrior
    next_space = feel

    if next_space.wall?
      @is_backward = false
    elsif next_space.captive?
      rescue!
    elsif !can_survive_any_attack?
      if !was_attacked?
        rest!
      else
        retreat!
      end
    elsif next_space.empty?
      walk!
    else
      attack!
    end

    @health_last_turn = warrior.health
  end
end
