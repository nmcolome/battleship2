require './lib/board'
require './lib/computer'
require './lib/player'

class BattleshipRunner
  def start
    print "Welcome to BATTLESHIP\nEnter p to play. Press any letter to quit.\n> "
    choice = gets.chomp
    setup if choice == 'p'
  end

  def setup
    print "Please enter the number of rows & columns of the board (eg 4 4).\n> "
    size = gets.chomp.split(' ')
    @computer = Computer.new(size[0], size[1])
    @player = Player.new(size[0], size[1])

    @computer.setup
    puts "You now need to lay out your two ships.\nThe Cruiser is two units long and the Submarine is three units long."
    puts @player.board.render
    puts 'To place your ships enter your coordinates with spaces (eg. A1 A2)'
    @player.setup
    puts "Ok! Let's play:"
    runner
  end

  def turn
    boards_printer(false)
    c_shot = @computer.shoot(@player.board)
    print "Enter the coordinate for your shot:\n> "
    p_shot = @player.shoot(@computer.board)
    @computer.result(p_shot, @computer.board)
    @player.result(c_shot, @player.board)
  end

  def runner
    until health_calculator(@computer).zero? || health_calculator(@player).zero?
      turn
    end

    boards_printer(true)
    who_won
    puts "\n"
    BattleshipRunner.new.start
  end

  def who_won
    if health_calculator(@computer).zero?
      puts 'You won!'
    elsif health_calculator(@player).zero?
      puts 'I won!'
    end
  end

  def boards_printer(option)
    puts "=============COMPUTER BOARD=============\n"
    puts @computer.board.render(option)
    puts "==============PLAYER BOARD==============\n"
    puts @player.board.render(true)
    puts "\n"
  end

  def health_calculator(player)
    player.ships.inject(0) { |sum, ship| sum + ship.health }
  end
end

BattleshipRunner.new.start
