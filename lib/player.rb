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
      print "Enter the squares for the #{ship.name} (#{ship.length} spaces):\n> "
      coordinates_prompt(ship)
    end
  end

  def coordinates_prompt(ship)
    input = gets.chomp
    cells = input.upcase.split(" ")
    if @board.valid_placement?(ship, cells)
      @board.place(ship, cells)
      puts @board.render(true)
    else
      print "Those are invalid coordinates. Please try again:\n> "
      coordinates_prompt(ship)
    end
  end

  def shoot(computer_board)
    shot = gets.chomp.upcase
    if computer_board.valid_coordinate?(shot)
      computer_board.cells[shot].fire_upon
    else
      print "Please enter a valid coordinate:\n> "
      shoot
    end
    shot
  end

  def result(shot, player_board)
    puts "My shot on #{shot} was a #{player_board.cells[shot].render}."
  end
end