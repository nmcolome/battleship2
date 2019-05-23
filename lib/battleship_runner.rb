require './lib/board'
# require './lib/cell'
# require './lib/ship'

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
    
  end
end

BattleshipRunner.new.start
