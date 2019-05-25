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

  def test_the_coordinates_generator_for_the_computer_ship_placement
    @ship = Ship.new("Cruiser", 2)

    assert_equal [["B", 2], ["B", 3]], @game.coordinates_generator("horizontal", "B", 2, @ship)
    assert_equal [["C", 3], ["D", 3]], @game.coordinates_generator("vertical", "C", 3, @ship)
    assert_equal [["D", 4], ["D", 5]], @game.coordinates_generator("horizontal", "D", 4, @ship)
    assert_equal [["D", 4], ["E", 4]], @game.coordinates_generator("vertical", "D", 4, @ship)
  end
end
