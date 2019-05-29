class User
  attr_reader :board, :cruiser, :submarine, :ships

  def initialize(row, column)
    @board = Board.new(row.to_i, column.to_i)
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