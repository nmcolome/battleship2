require './lib/board'

class Computer
  attr_reader :board, :cruiser, :submarine

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 2)
    @submarine = Ship.new("Submarine", 3)
  end

  def setup
    ships = [@cruiser, @submarine]
    ships.each { |ship| assign_coordinates(ship) }
    puts "I have laid out my ships on the grid."
  end

  def assign_coordinates(ship)
    direction, starting_row, starting_column = random_cell_generator
    pairs = coordinates_generator(direction, starting_row, starting_column, ship)
    cells = pairs.map { |pair| pair.join("") }
    if @board.valid_placement?(ship, cells)
      @board.place(ship, cells)
    else
      assign_coordinates(ship)
    end
  end

  def coordinates_generator(direction, starting_row, starting_column, ship)
    abc = [*"A".."Z"]
    if direction == "horizontal"
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

  def shoot(player_board)
    available_cells = player_board.cells.keys.find_all { |key| player_board.cells[key].fired_upon? == false }
    shot = available_cells.sample
    player_board.cells[shot].fire_upon
    shot
  end

  def result(shot, computer_board)
    letter = computer_board.cells[shot].render
    puts "Your shot on #{shot} #{meanings[letter]}."
  end

  def meanings
    {
      "M" => "was a miss",
      "H" => "was a hit",
      "X" => "sunk a ship"
    }
  end
end