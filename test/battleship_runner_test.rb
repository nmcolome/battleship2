require 'minitest/autorun'
require 'minitest/pride'
require './lib/battleship_runner'

class BattleshipRunnerTest < Minitest::Test
  def setup
    @game = BattleshipRunner.new
  end

  def test_it_exists
    assert_instance_of BattleshipRunner, @game
  end
end
