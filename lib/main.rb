require './lib/board.rb'

loop do
  game = Game.new()

  until game.check
    guess = gets.chomp
    game.guess(guess)
  end

  response = 'a'
  puts "\nWould you like to start a new game? Y/N"

  until response == 'y' || response == 'n'
    response = gets.chomp.downcase
  end
  
  if response == 'n'
    break
  end
end
