require 'test/unit'
require_relative '../../simulate/space_sim'

class TestSpaceSim < Test::Unit::TestCase
  def test_to_s
    wall = SpaceSim.new(nil, "|")
    warrior = SpaceSim.new(nil, "@")
    empty = SpaceSim.new(nil, " ")
    stairs = SpaceSim.new(nil, ">")
    sludge = SpaceSim.new(nil, "s")

    assert_equal("|", wall.to_s)
    assert_equal("@", warrior.to_s)
    assert_equal(" ", empty.to_s)
    assert_equal(">", stairs.to_s)
    assert_equal("s", sludge.to_s)
  end
end