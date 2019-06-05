class User
  attr_reader :board, :ships

  def initialize(size, ships_data)
    @board = Board.new(size[0], size[1])
    ship_generator(ships_data)
    @shots = []
  end

  def ship_generator(ships_data)
    @ships = {}
    ships_data.each do |ship|
      @ships[ship[0]] = Ship.new(ship[0].capitalize, ship[1].to_i)
    end
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
