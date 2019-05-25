require './lib/board'
# require './lib/cell'
# require './lib/ship'
require 'pry'
require './lib/computer'

class BattleshipRunner

  def initialize
    @computer = Computer.new
    @player_board = Board.new
    @p_cruiser = Ship.new("Cruiser", 2)
    @p_submarine = Ship.new("Submarine", 3)
  end

  def start
    puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."
    choice = gets.chomp
    setup if choice == "p"
  end

  def setup
    @computer.setup
    puts "You now need to lay out your two ships.\nThe Cruiser is two units long and the Submarine is three units long."
    puts @player_board.render
    puts "To place your ships enter your coordinates as: A1 A2..."
    player_setup
    puts "Ok! Let's play:"
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

  def player_setup
    ships = [@p_cruiser, @p_submarine]
    ships.each do |ship|
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
      coordinates_prompt(ship)
    end
  end

  def coordinates_prompt(ship)
    input = gets.chomp
    cells = input.split(" ")
    if @player_board.valid_placement?(ship, cells)
      @player_board.place(ship, cells)
      puts @player_board.render(true)
    else
      puts "Those are invalid coordinates. Please try again:"
      coordinates_prompt(ship)
    end
  end
end

BattleshipRunner.new.start
