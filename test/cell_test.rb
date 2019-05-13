require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_it_has_a_coordinate
    assert "B4", @cell.coordinate
  end

  def test_it_returns_if_it_contains_a_ship
    assert_nil @cell.ship
  end

  def test_it_returns_if_its_empty
    assert @cell.empty?
  end

  def test_it_can_place_a_ship
    @cell.place_ship(@cruiser)

    refute @cell.empty?
  end

  def test_it_returns_a_ship_if_it_contains_one
    @cell.place_ship(@cruiser)

    assert_instance_of Ship, @cell.ship
  end
end