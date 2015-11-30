require 'test/unit'
require_relative '../simulate/level_sim'
require_relative '../player'

class TestPlayer < Test::Unit::TestCase
  def test_passes_level_1
    level = LevelSim.new("|@      >|")
    player = Player.new
    has_passed = false
    turn_number = 1

    while !has_passed && turn_number < 8
      has_passed = level.play_turn!(player)
      turn_number += 1
    end
  end
end
