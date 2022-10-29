require './lib/board.rb'

game = Game.new()

loop do
  guess = gets.chomp
  game.guess(guess)
end