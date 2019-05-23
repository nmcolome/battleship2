require './lib/board'
# require './lib/cell'
# require './lib/ship'
require 'pry'

class BattleshipRunner

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @c_cruiser = Ship.new("Cruiser", 2)
    @p_cruiser = Ship.new("Cruiser", 2)
    @c_submarine = Ship.new("Submarine", 3)
    @p_submarine = Ship.new("Submarine", 3)
  end

  def start
    puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."
    choice = gets.chomp
    setup if choice == "p"
  end

  def setup
    computer_setup
  end
  
  def computer_setup
    abc = [*"A".."Z"]
    ships = [@c_cruiser, @c_submarine]
    ships.each do |ship|
      cell = @computer_board.cells.keys.sample
      direction = %w[vertical horizontal].sample
      starting_row = cell[0]
      starting_column = cell[1].to_i
      if direction == "horizontal"
        rows = Array.new(ship.length, starting_row)
        columns = [*starting_column...(starting_column + ship.length)]
      else
        columns = Array.new(ship.length, starting_column)
        starting_index = abc.index(starting_row)
        rows = abc.slice(starting_index, ship.length)
      end
      pairs = rows.zip(columns)
      cells = pairs.map { |pair| pair.join("") }
      result = @computer_board.valid_placement?(ship, cells) ? @computer_board.place(ship, cells) : "fail"
    end
  end
end

BattleshipRunner.new.start
