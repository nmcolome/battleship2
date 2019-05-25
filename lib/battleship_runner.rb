require './lib/board'
require 'pry'
require './lib/computer'
require './lib/player'

class BattleshipRunner

  def initialize
    @computer = Computer.new
    @player = Player.new
  end

  def start
    print "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit.\n> "
    choice = gets.chomp
    setup if choice == "p"
  end

  def setup
    @computer.setup
    puts "You now need to lay out your two ships.\nThe Cruiser is two units long and the Submarine is three units long."
    puts @player.board.render
    print "To place your ships enter your coordinates with spaces (eg. A1 A2)"
    @player.setup
    puts "Ok! Let's play:"
    turn
  end

  def turn
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
    # @player.shoot
  end
end

BattleshipRunner.new.start
