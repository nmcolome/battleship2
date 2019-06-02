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

  # def shoot(player_board)
  #   binding.pry
  #   shot = available_cells(player_board).sample
  #   player_board.cells[shot].fire_upon
  #   shot
  # end

  def available_cells(board)
    board.cells.keys.find_all { |key| board.cells[key].fired_upon? == false }
  end

  def shoot(player_board)
    binding.pry
    if @shots.empty?
      shot = player_board.cells.keys.sample
      player_board.cells[shot].fire_upon
      @shots << shot
    elsif player_board.cells[@shots[-1]].render == "H"
      #do someting
    else
      shot = available_cells(player_board).sample
      player_board.cells[shot].fire_upon
      @shots << shot
    end
    shot
  end
end
