require './lib/board'
require './lib/computer'
require './lib/player'

class BattleshipRunner
  def start
    print "Welcome to BATTLESHIP\nEnter p to play. Press any key to quit.\n> "
    choice = gets.chomp
    setup if choice == 'p'
  end

  def setup
    ships_data = ships_prompt
    size = board_prompt
    @computer = Computer.new(size, ships_data)
    @player = Player.new(size, ships_data)
    @computer.setup
    ships_description_msg(ships_data)
    puts 'To place your ships enter your coordinates with spaces (eg. A1 A2)'
    @player.setup
    puts "Ok! Let's play:"
    runner
  end

  def ships_description_msg(ships)
    puts "You now need to lay out your #{ships.count} ships."
    puts msg_builder(ships)
    puts @player.board.render
  end

  def msg_builder(ships)
    sentences = ships.map { |ship| "the #{ship[0]} is #{ship[1]} units long" }
    phrase = sentences.join(', ')
    phrase.insert(phrase.rindex(',') + 1, ' and') if ships.count > 1
    phrase.capitalize + '.'
  end

  def board_prompt
    print "Please enter the number of rows & columns of the board (eg 4 4).\n> "
    dimensions = gets.chomp.split(' ').map(&:to_i)
    until dimensions.count == 2 && dimensions.none?(&:zero?)
      print "Please enter valid dimensions.\n> "
      dimensions = gets.chomp.split(' ').map(&:to_i)
    end
    dimensions
  end

  def ships_prompt
    print "Press y to create your ships. Press p to use 2 ships by default:\n> "
    option = gets.chomp.downcase
    ships_prompt_path(option)
  end

  def ships_prompt_path(option)
    if option == 'y'
      print 'Please enter the name and size of the ship (eg. Cruiser 3).'
      print " Enter 'done' when you're finished\n> "
      ships_prompt_loop
    elsif option == 'p'
      [%w[destroyer 2], %w[submarine 3]]
    else
      ships_prompt
    end
  end

  def ships_prompt_loop
    ships_data = []
    ship_info = gets.chomp.downcase

    until ship_info == 'done' && !ships_data.empty?
      input = ship_info.split(' ')
      ship_input_validation(ships_data, input)
      ship_info = gets.chomp.downcase
    end
    ships_data
  end

  def ship_input_validation(ships_data, input)
    if input[0] == 'done' && ships_data.empty?
      print "You must enter at least one ship\n> "
    elsif input.count == 2 && input[0].match?(/[a-zA-Z]+/) && input[1].to_i != 0
      ships_data << input
      print "Please enter the name and size of the ship or enter 'done'\n> "
    else
      print "Please enter a valid name and size or enter 'done'\n> "
    end
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
    player.ships.values.inject(0) { |sum, ship| sum + ship.health }
  end
end

BattleshipRunner.new.start
