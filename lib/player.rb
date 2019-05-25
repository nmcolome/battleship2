require './lib/board'

class Player
  attr_reader :board, :cruiser, :submarine

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 2)
    @submarine = Ship.new("Submarine", 3)
  end

  def setup
    ships = [@cruiser, @submarine]
    ships.each do |ship|
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
      coordinates_prompt(ship)
    end
  end

  def coordinates_prompt(ship)
    input = gets.chomp
    cells = input.split(" ")
    if @board.valid_placement?(ship, cells)
      @board.place(ship, cells)
      puts @board.render(true)
    else
      puts "Those are invalid coordinates. Please try again:"
      coordinates_prompt(ship)
    end
  end
end