require './lib/board'

class Player
  attr_reader :board, :cruiser, :submarine, :ships

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 2)
    @submarine = Ship.new("Submarine", 3)
    @ships = [@cruiser, @submarine]
  end

  def setup
    @ships.each do |ship|
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
    while !computer_board.valid_coordinate?(shot) do
      print "Please enter a valid coordinate:\n> "
      shot = gets.chomp.upcase
    end

    while computer_board.cells[shot].fired_upon? do
      print "You have already fired on that coordinate. Please enter a new one:\n> "
      shot = gets.chomp.upcase
    end
    computer_board.cells[shot].fire_upon
    shot
  end

  def result(shot, player_board)
    letter = player_board.cells[shot].render
    puts "My shot on #{shot} #{meanings[letter]}."
  end

  def meanings
    {
      "M" => "was a miss",
      "H" => "was a hit",
      "X" => "sunk a ship"
    }
  end
end