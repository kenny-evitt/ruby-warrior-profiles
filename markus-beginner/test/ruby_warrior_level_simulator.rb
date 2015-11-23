require_relative 'mock_ruby_warrior_space'

class RubyWarriorLevelSimulator

  ##
  # Initialize a new instance.
  def initialize(level_s, stairs_index = nil)
    @spaces = []

    level_s.each do |c|
      case c
        when " "
        @spaces <<
      end
    end
  end
end