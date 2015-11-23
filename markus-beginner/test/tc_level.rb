require 'test/unit'
require_relative '../level'
require_relative 'mock_ruby_warrior_space'

class TestLevel < Test::Unit::TestCase
  def test_initial_current_space_index_is_zero
    level = Level.new
    assert_equal(0, level.current_space_index)
  end

  def test_initial_left_space_index_is_negative_one
    level = Level.new
    assert_equal(-1, level.left_space_index)
  end

  def test_initial_right_space_index_is_positive_one
    level = Level.new
    assert_equal(1, level.right_space_index)
  end

  def test_initial_spaces_count_is_three
    level = Level.new
    assert_equal(3, level.spaces.length)
  end

  def test_initial_to_s
    level = Level.new
    assert_equal("?@?", level.to_s)
  end

  def test_initial_update_with_really_empty_spaces
    level = Level.new
    left_space = MockRubyWarriorSpace.new_really_empty_space
    right_space = MockRubyWarriorSpace.new_really_empty_space
    level.update(left_space, right_space)

    # Because the adjacent spaces are empty, we know there is at least one other space in both directions.
    assert_equal(5, level.spaces.length)
    assert_equal("? @ ?", level.to_s)
  end

  def test_walk_left
    level = Level.new
    left_space = MockRubyWarriorSpace.new_really_empty_space
    right_space = MockRubyWarriorSpace.new_really_empty_space
    level.update(left_space, right_space)
    level.walk!(:left)

    assert_equal(-1, level.current_space_index)
    assert_equal("?@* ?", level.to_s)
  end

  def test_walk_right
    level = Level.new
    left_space = MockRubyWarriorSpace.new_really_empty_space
    right_space = MockRubyWarriorSpace.new_really_empty_space
    level.update(left_space, right_space)
    level.walk!(:right)

    assert_equal(1, level.current_space_index)
    assert_equal("? *@?", level.to_s)
  end

  def test_find_next_enemy
    level = Level.new
    left_space = MockRubyWarriorSpace.new_really_empty_space
    right_space = MockRubyWarriorSpace.new_really_empty_space
    level.update(left_space, right_space)

    next_enemy_left = level.find_next_enemy(:left)
    next_enemy_right = level.find_next_enemy(:right)

    assert_equal(-2, next_enemy_left.index)
    assert_equal(2, next_enemy_right.index)
  end
end
