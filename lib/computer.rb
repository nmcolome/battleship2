require './lib/board'
require './lib/user'
require 'pry'

class Computer < User
  def setup
    @ships.values.each { |ship| assign_coordinates(ship) }
    puts 'I have laid out my ships on the grid.'
  end

  def assign_coordinates(ship)
    direction, starting_row, starting_column = random_cell_generator
    pairs = coordinates_generator(direction, starting_row, starting_column, ship)
    cells = pairs.map { |pair| pair.join('') }
    if @board.valid_placement?(ship, cells)
      @board.place(ship, cells)
    else
      assign_coordinates(ship)
    end
  end

  def coordinates_generator(direction, starting_row, starting_column, ship)
    abc = [*'A'..'Z']
    if direction == 'horizontal'
      rows = Array.new(ship.length, starting_row)
      columns = [*starting_column...(starting_column + ship.length)]
    else
      columns = Array.new(ship.length, starting_column)
      starting_index = abc.index(starting_row)
      rows = abc.slice(starting_index, ship.length)
    end
    rows.zip(columns)
  end

  def random_cell_generator
    cell = @board.cells.keys.sample
    direction = %w[vertical horizontal].sample
    starting_row = cell[0]
    starting_column = cell[1].to_i
    [direction, starting_row, starting_column, cell]
  end

  def available_cells(board)
    board.cells.keys.find_all { |key| board.cells[key].fired_upon? == false }
  end

  def hits(board)
    @shots.select { |shot| board.cells[shot].render == 'H' }
  end

  def available_surrounding_cells(player_board)
    hit = hits(player_board).sample
    row, col = hit.scan(/[A-Z]+/)[0], hit.scan(/\d+/)[0].to_i
    surrounding_rows = surrounding_cells(player_board.rows, row)
    surrounding_cols = surrounding_cells(player_board.cols, col)
    horizontal = Array.new(surrounding_cols.length, row)
    horiz_cells = horizontal.zip(surrounding_cols)
    vertical = Array.new(surrounding_rows.length, col)
    verti_cells = (surrounding_rows).zip(vertical)
    pairs = horiz_cells | verti_cells
    cells = pairs.map { |pair| pair.join('') }
    cells.select { |shot| player_board.cells[shot].fired_upon? == false }
  end

  def surrounding_cells(reference, element)
    if reference[0] == element
      reference[0..1]
    elsif reference[-1] == element
      reference[-2..-1]
    else
      element_i = reference.index(element)
      reference[(element_i - 1)..(element_i + 1)]
    end
  end

  def shoot(player_board)
    if @shots.empty?
      shot = player_board.cells.keys.sample
    elsif !hits(player_board).empty?
      shot = available_surrounding_cells(player_board).sample while shot.nil?
    else
      shot = available_cells(player_board).sample
    end
    player_board.cells[shot].fire_upon
    @shots << shot
    shot
  end
end
