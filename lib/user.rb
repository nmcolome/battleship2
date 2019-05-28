class User
  attr_reader :board, :cruiser, :submarine, :ships

  def initialize
    @board = Board.new(4, 4) # TODO: take input from user
    @cruiser = Ship.new('Cruiser', 2)
    @submarine = Ship.new('Submarine', 3)
    @ships = [@cruiser, @submarine]
  end

  def meanings
    {
      'M' => 'was a miss',
      'H' => 'was a hit',
      'X' => 'sunk a ship'
    }
  end

  def result(shot, board)
    letter = board.cells[shot].render
    shot_feedback(shot, letter)
  end

  def shot_feedback(shot, letter)
    puts "\nYour shot on #{shot} #{meanings[letter]}."
  end
end