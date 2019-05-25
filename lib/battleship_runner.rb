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
    puts "You now need to lay out your two ships.\nThe Cruiser is two units long and the Submarine is three units long."
    puts @player_board.render
    puts "To place your ships enter your coordinates as: A1 A2..."
    player_setup
    puts "Ok! Let's play:"
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
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

  def computer_setup
    ships = [@c_cruiser, @c_submarine]
    ships.each { |ship| assign_coordinates(ship) }
    puts "I have laid out my ships on the grid."
  end

  def assign_coordinates(ship)
    direction, starting_row, starting_column = random_cell_generator
    pairs = coordinates_generator(direction, starting_row, starting_column, ship)
    cells = pairs.map { |pair| pair.join("") }
    if @computer_board.valid_placement?(ship, cells)
      @computer_board.place(ship, cells)
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
    cell = @computer_board.cells.keys.sample
    direction = %w[vertical horizontal].sample
    starting_row = cell[0]
    starting_column = cell[1].to_i
    [direction, starting_row, starting_column, cell]
  end
end

BattleshipRunner.new.start
