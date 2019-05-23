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

  def test_welcome_message
    message = "Welcome to BATTLESHIP
    Enter p to play. Enter q to quit."

    assert message, @game.start
  end
end
