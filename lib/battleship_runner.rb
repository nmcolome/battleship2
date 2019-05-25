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
    puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."
    choice = gets.chomp
    setup if choice == "p"
  end

  def setup
    @computer.setup
    puts "You now need to lay out your two ships.\nThe Cruiser is two units long and the Submarine is three units long."
    puts @player.board.render
    puts "To place your ships enter your coordinates as: A1 A2..."
    @player.setup
    puts "Ok! Let's play:"
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
  end
end

BattleshipRunner.new.start
