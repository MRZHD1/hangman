LETTERS = ('a'..'z').to_a
WORDS = File.readlines('words.txt').map {|word| word[..-2]}.filter{|word| word.length > 4 && word.length < 13} # Removes the '\n' and too long / short words

class Game
  @@wins = 0
  @@losses = 0

  def initialize()
    @word = WORDS.sample
    @guesses = []
    @bad_guesses = []
    @display = ['_']*@word.length
    puts "Wins: #{@@wins} / Losses: #{@@losses}"
    puts @display.join(' ')
    puts "\nGuess a letter!\n"
  end

  def guess(letter)

    letter.downcase!
    if LETTERS.include?(letter) && !(@guesses.include?(letter))

      @guesses.push(letter)

      if @word.include?(letter)
        indicies = @word.split('').each_index.select{|index| @word[index] == letter}
        indicies.each{|index| @display[index] = letter}
        display('Nice guess!')
      else
        @bad_guesses.push(letter)
        display('Bad guess!')
      end
    else
      display('You already guessed that, or it is an invalid letter!')
    end
  end

  def display(msg = '')
    system('clear')
    puts "#{msg}\n"
    puts @display.join(' ')
    puts "\n"
  end
end