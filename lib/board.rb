LETTERS = ('a'..'z').to_a
WORDS = File.readlines('words.txt').map {|word| word[..-2]}.filter{|word| word.length > 4 && word.length < 13} # Removes the '\n' and too long / short words

class Game
  @@wins = 0
  @@losses = 0

  def initialize()
    @word = WORDS.sample
    @guesses = []
    @bad_guesses = []
    @saved = false
    @display = ['_']*@word.length

    puts "If you would like to load a game, type in load, otherwise type in any key"

    if gets.chomp.downcase == 'load'
      load()
    else
      display('Guess a letter!')
    end
    
  end

  def guess(letter)
    letter.downcase!

    if letter == 'save'
      save()
      display('Game saved.')
      @save = false

    elsif LETTERS.include?(letter) && !(@guesses.include?(letter))

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

  def check
    if @saved
      return true
    elsif @word.split('') == @display
      @@wins += 1
      display('Good game, you won!')
      return true
    elsif @bad_guesses.length == 7
      @@losses += 1
      display("Sorry, you lost! The correct word was #{@word}")
      return true
    else
      return false
    end
  end

  private
  def display(msg = '')
    system('clear')
    puts """If you wish to save a game, type in 'save'\n
    Wins: #{@@wins} / Losses: #{@@losses}
    -------------------------------
    #{msg}
    Bad guesses: #{@bad_guesses.join(' ')}
    #{@display.join(' ')}
    \n"""
  end

  private
  def load
    list = ""
    game_data = File.read('./saved_games.txt').split.each_slice(2).to_a

    game_data.each_with_index do |game, index|
      list += "\n#{index} | Word length: #{game[1].split(',')[0].length} / Bad guesses: #{game[0]} / Remaining number of guesses: #{7 - game[0].length}"
    end

    puts list.chomp
    puts "What game would you like to load? Type in the number you wish to load, otherwise type in an invalid number to pick a random word"

    num = gets.chomp
    if ('0'..(game_data.length-1).to_s).to_a.include?(num)
      num = num.to_i
      @word = game_data[num][1].split(',')[0]
      @display = game_data[num][1].split(',')[1].split('')
      @bad_guesses = game_data[num][0].split(',')
      @guesses = @bad_guesses + ((@display.join('').delete "_").split(''))
      
      display('Game successfully loaded! Guess a letter.')
    else
      display('Invalid game number, started a new game. Guess a letter!')
    end
  end

  private
  def save
    File.write("./saved_games.txt", "\n#{@bad_guesses.join(',')}\n#{@word},#{@display.join('')}", mode: "a")
    @saved = true
  end

end