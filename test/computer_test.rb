require './test/test_helper.rb'
require './lib/computer'
require './lib/player'

class ComputerTest < Minitest::Test
  def setup
    @computer = Computer.new(4, 4)
    @player = Player.new(4, 4)
  end

  def test_the_coordinates_generator_for_the_computer_ship_placement
    @ship = Ship.new('Cruiser', 2)

    assert_equal [['B', 2], ['B', 3]], @computer.coordinates_generator('horizontal', 'B', 2, @ship)
    assert_equal [['C', 3], ['D', 3]], @computer.coordinates_generator('vertical', 'C', 3, @ship)
    assert_equal [['D', 4], ['D', 5]], @computer.coordinates_generator('horizontal', 'D', 4, @ship)
    assert_equal [['D', 4], ['E', 4]], @computer.coordinates_generator('vertical', 'D', 4, @ship)
  end

  def test_it_shoots_only_new_cells
    cells = @player.board.cells
    %w[A1 A2 A3 A4 C1 C3 D2 D3].each { |key| cells[key].fire_upon }
    available_cells = %w[B1 B2 B3 B4 C2 C4 D1 D4]

    assert available_cells.include?(@computer.shoot(@player.board))
  end
end
