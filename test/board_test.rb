require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require 'pry'
class BoardTest < Minitest::Test
  def setup
    @board = Board.new(4, 4)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_has_cells
    assert_instance_of Hash, @board.cells
    assert_instance_of Cell, @board.cells["A1"]
    assert_equal 16, @board.cells.length
  end

  def test_it_returns_if_coordinate_exists
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end

  def test_valid_placement_matches_number_of_coordinates_with_ship_length
    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
  end

  def test_valid_placement_verifies_coordinates_are_consecutive
    refute @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    refute @board.valid_placement?(@submarine, ["A1", "C1"])
    refute @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    refute @board.valid_placement?(@submarine, ["C1", "B1"])
  end

  def test_valid_placement_verifies_coordinates_are_not_diagonal
    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_valid_placement_verifies_all_three_conditions
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_it_can_place_a_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]
    binding.pry

    assert_equal @cruiser, cell_1.ship
    assert_equal @cruiser, cell_2.ship
    assert_equal @cruiser, cell_3.ship
    assert_equal cell_3.ship, cell_2.ship
  end

  def test_valid_placement_verifies_there_is_no_overlap
    @board.place(@cruiser, ["A1", "A2", "A3"])

    refute @board.valid_placement?(@submarine, ["A1", "B1"])
  end

  def test_render_the_board
    @board.place(@cruiser, ["A1", "A2", "A3"])
    rendering = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

    assert_equal rendering, @board.render
  end

  def test_render_the_board_showing_hidden_ships
    @board.place(@cruiser, ["A1", "A2", "A3"])
    rendering = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

    assert_equal rendering, @board.render(true)
  end

  def test_valid_placement_verifies_coordinates_are_within_board
    refute @board.valid_placement?(@cruiser, ["D3", "D4", "D5"])
    refute @board.valid_placement?(@submarine, ["D4", "E4"])
  end

  def test_generator_of_cell_names
    rows = 4
    columns = 4
    result = ["A1","A2","A3","A4","B1","B2","B3","B4","C1","C2","C3","C4","D1","D2","D3","D4"]

    assert_equal result, @board.generator(rows, columns)
  end

end


