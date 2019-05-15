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

  def test_it_returns_if_fired_upon
    refute @cell.fired_upon?
  end

  def test_it_can_be_fired_upon
    @cell.fire_upon

    assert @cell.fired_upon?
  end

  def test_firing_hurts_a_ship
    @cell.place_ship(@cruiser)

    assert 3, @cell.ship.health
    refute @cell.fired_upon?

    @cell.fire_upon
    assert 2, @cell.ship.health
    assert @cell.fired_upon?
  end

  def test_it_renders_a_dot_if_a_cell_has_not_been_fired_upon
    assert_equal ".", @cell.render
  end

  def test_it_renders_an_M_if_the_cell_has_been_fired_upon_and_it_does_not_contain_a_ship
    @cell.fire_upon

    assert_equal "M", @cell.render
  end

  def test_it_renders_an_H_if_the_cell_has_been_fired_upon_and_it_contains_a_ship
    @cell.place_ship(@cruiser)
    @cell.fire_upon

    assert_equal "H", @cell.render
  end

  def test_it_renders_an_X_if_the_cell_has_been_fired_upon_and_its_ship_has_been_sunk
    @cell.place_ship(@cruiser)
    @cell.fire_upon

    assert_equal "H", @cell.render
    refute @cruiser.sunk?

    @cruiser.hit
    @cruiser.hit
    assert @cruiser.sunk?
    assert_equal "X", @cell.render
  end

  def test_it_renders_an_S_to_reveal_a_ship
    @cell.place_ship(@cruiser)

    assert_equal "S", @cell.render(true)
  end
end
