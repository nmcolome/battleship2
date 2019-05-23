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
    ships = [@c_cruiser, @c_submarine]
    ships.each do |ship|
      cell = @computer_board.cells.keys.sample
      direction = %w[vertical horizontal].sample
        if direction == horizontal
          starting_row = cell[0]
          rows = Array.new(ship.length, starting_row)
          starting_column = cell[1]
          columns = (starting_column...(starting_column + ship.length))
          pairs = rows.zip(columns)
          cells = pairs.map { |pair| pair.join("")}

  end
end

BattleshipRunner.new.start
