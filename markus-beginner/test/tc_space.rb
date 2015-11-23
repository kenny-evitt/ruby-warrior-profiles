require 'test/unit'
require_relative '../space'
require_relative 'mock_ruby_warrior_space'

class TestSpace < Test::Unit::TestCase
  def test_initial_space_with_no_ruby_warrior_space_is_mostly_ambiguous
    space = Space.new(0, nil)

    assert_equal(0, space.index)

    assert_equal(:maybe, space.empty?)
    assert_equal(:maybe, space.stairs?)
    assert_equal(:maybe, space.enemy?)
    assert_equal(:maybe, space.captive?)
    assert_equal(:maybe, space.wall?)
    assert_equal(:maybe, space.bomb?)
    assert_equal(:maybe, space.golem?)

    assert_equal(false, space.warrior?)
    assert_equal(false, space.start?)
  end

  def test_updated_space_is_not_ambiguous
    space = Space.new(0, nil)
    ruby_warrior_empty_space = MockRubyWarriorSpace.new_really_empty_space
    space.update(ruby_warrior_empty_space)

    assert_equal(0, space.index)

    assert_equal(true, space.empty?)

    assert_equal(false, space.stairs?)
    assert_equal(false, space.enemy?)
    assert_equal(false, space.captive?)
    assert_equal(false, space.wall?)
    assert_equal(false, space.bomb?)
    assert_equal(false, space.golem?)
  end
end