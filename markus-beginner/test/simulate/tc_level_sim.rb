require 'test/unit'
require_relative '../../simulate/level_sim'
require_relative '../../simulate/sludge_sim'
require_relative 'mock_player'

class TestLevelSim < Test::Unit::TestCase
  STANDER = MockPlayer.new { }
  WALKER = MockPlayer.new { |warrior| warrior.walk! }

  def test_to_s
    level1 = LevelSim.new("|@      >|")
    level2 = LevelSim.new("|@   s  >|")

    assert_equal("|@      >|", level1.to_s)
    assert_equal("|@   s  >|", level2.to_s)
  end

  def test_walk
    level = LevelSim.new("@ ")
    level.try_warrior_walk!
    assert_equal(" @", level.to_s)
  end

  def test_walking_onto_stairs_passes_level
    level = LevelSim.new("@ >")
    walker = WALKER

    has_passed = level.play_turn!(walker)
    assert_equal(" @>", level.to_s)
    assert_equal(false, has_passed)

    has_passed = level.play_turn!(walker)
    assert_equal("  @", level.to_s)
    assert_equal(true, has_passed)
  end

  def test_warrior_can_feel
    level_empty = LevelSim.new("@ ")
    level_sludge = LevelSim.new("@s")

    assert(level_empty.warrior.feel.empty?)
    assert(level_sludge.warrior.feel.enemy?)
  end

  def test_warrior_cannot_walk_into_space_with_sludge
    level = LevelSim.new("@s")
    level.try_warrior_walk!
    assert_equal("@s", level.to_s)
  end

  def test_sludge_attacks_warrior_if_adjacent
    level = LevelSim.new("@s")
    level.play_turn!(STANDER)
    assert_equal(WarriorSim::INITIAL_HP - SludgeSim::ATTACK_DAMAGE, level.warrior.hp)
  end

  def test_sludge_does_not_attack_if_warrior_is_not_adjacent
    level_four_spaces_away_stander = LevelSim.new("@   s")
    level_three_spaces_away_stander = LevelSim.new("@  s")
    level_two_spaces_away_stander = LevelSim.new("@ s")

    level_four_spaces_away_walker = LevelSim.new("@   s")
    level_three_spaces_away_walker = LevelSim.new("@  s")
    level_two_spaces_away_walker = LevelSim.new("@ s")


    level_four_spaces_away_stander.play_turn!(STANDER)
    level_three_spaces_away_stander.play_turn!(STANDER)
    level_two_spaces_away_stander.play_turn!(STANDER)

    level_four_spaces_away_walker.play_turn!(WALKER)
    level_three_spaces_away_walker.play_turn!(WALKER)
    level_two_spaces_away_walker.play_turn!(WALKER)


    assert_equal(WarriorSim::INITIAL_HP, level_four_spaces_away_stander.warrior.hp)
    assert_equal(WarriorSim::INITIAL_HP, level_three_spaces_away_stander.warrior.hp)
    assert_equal(WarriorSim::INITIAL_HP, level_two_spaces_away_stander.warrior.hp)

    assert_equal(WarriorSim::INITIAL_HP, level_four_spaces_away_walker.warrior.hp)
    assert_equal(WarriorSim::INITIAL_HP, level_three_spaces_away_walker.warrior.hp)
    assert_equal(WarriorSim::INITIAL_HP, level_two_spaces_away_walker.warrior.hp)
  end
end