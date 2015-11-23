require_relative "level"


class Player

  # Constants

  MIN_TOTAL_ATTACKING_DAMAGE_SLUDGE = 6
  MIN_TOTAL_ATTACKING_DAMAGE_THICK_SLUDGE = 12
  MIN_TOTAL_ATTACKING_DAMAGE_ARCHER = 12

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
    @level = Level.new
    @mode = :explore
  end


  # Instance methods

  def attack!
    if @is_backward
      @current_warrior.attack! :backward
    else
      @current_warrior.attack!
    end
  end

  def can_survive_attacking_any_enemy?
    health >= Player.min_health_to_survive_attack
  end

  def damage_last_turn
    (@health_last_turn || health) - health
  end

  def feel
    left_space = @current_warrior.feel :backward
    right_space = @current_warrior.feel
    @level.update(left_space, right_space)
    print "DEBUG - Level: _#{@level}_\n"

    if @is_backward
      left_space
    else
      right_space
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
      @level.walk! :right
    else
      @current_warrior.walk! :backward
      @level.walk! :left
    end
  end

  def should_retreat?
    was_attacked? && (health - damage_last_turn) < Player.min_health_to_survive_retreat
  end

  def walk!
    if @is_backward
      @current_warrior.walk! :backward
      @level.walk! :left
    else
      @current_warrior.walk!
      @level.walk! :right
    end
  end

  def was_attacked?
    health < (@health_last_turn || 0)
  end


  # Play-turn method

  def play_turn(warrior)
    @current_warrior = warrior
    next_space = feel

    case @mode
    when :explore
      explore!
    when :fight
      fight!
    else
      explore!
    end

    @health_last_turn = warrior.health
  end


  # Mode methods

  def explore!
    @mode = :explore
    next_space = feel

    if next_space.enemy?
      fight! next_space
    elsif was_attacked?
      fight!
    elsif next_space.wall?
      @is_backward = false
      walk!
    elsif next_space.captive?
      rescue!
    elsif next_space.empty?
      walk!
    end
  end

  def fight!(enemy_target_space = nil)
    @mode = :fight

    if !enemy_target_space.nil?
      @current_enemy_target = enemy_target_space
    end

    if @current_enemy_target.nil?
      @current_enemy_target = if @is_backward
        @level.find_next_enemy :left
      else
        @level.find_next_enemy :right
      end
    end

    next_space = @level.next_space_towards_target(@current_enemy_target)

    if next_space.empty?
      walk!
    else
      attack!
    end
end
