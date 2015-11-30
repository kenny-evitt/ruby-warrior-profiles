class MockPlayer

  def initialize(&play_turn_block)
    @play_turn_block = play_turn_block
  end

  # @param warrior [WarriorSim]
  def play_turn(warrior)
    if @play_turn_block
      @play_turn_block.call(warrior)
    end
  end
end