require './lib/board'

class Player
  attr_reader :board, :cruiser, :submarine, :ships

  def initialize
    @board = Board.new(4, 4) # TODO: take input from user
    @cruiser = Ship.new('Cruiser', 2)
    @submarine = Ship.new('Submarine', 3)
    @ships = [@cruiser, @submarine]
  end

  def setup
    @ships.each do |ship|
      print "Enter the cells for the #{ship.name} (#{ship.length} spaces):\n> "
      coordinates_prompt(ship)
    end
  end

  def coordinates_prompt(ship)
    input = gets.chomp
    cells = input.upcase.split(' ')
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
    while !computer_board.valid_coordinate?(shot) || computer_board.cells[shot].fired_upon?
      coordinate_feedback(computer_board, shot)
      shot = gets.chomp.upcase
    end

    computer_board.cells[shot].fire_upon
    shot
  end

  def coordinate_feedback(board, shot)
    if !board.valid_coordinate?(shot)
      print "Please enter a valid coordinate:\n> "
    else
      print "You have already fired on that cell. Please enter a new one:\n> "
    end
  end

  def result(shot, board)
    letter = board.cells[shot].render
    puts "My shot on #{shot} #{meanings[letter]}."
  end

  def meanings
    {
      'M' => 'was a miss',
      'H' => 'was a hit',
      'X' => 'sunk a ship'
    }
  end
end
