class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(xter)
    if xter == nil || !(xter.class == String && xter =~ /^[A-z]$/i)
      raise ArgumentError
    end
    xter.downcase!
    if @guesses.include?(xter) || @wrong_guesses.include?(xter)
      return false
    end
    if @word.include?(xter)
      @guesses << xter
    else
      @wrong_guesses << xter
    end
  end

  def word_with_guesses
    disp = ''
    @word.split('').each do |xter|
      if @guesses.include?(xter)
        disp << xter
      else
        disp << '-'
      end
    end
    return disp
  end

  def check_win_or_lose
    if word_with_guesses.downcase == @word.downcase
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    begin
      require 'uri'
      require 'net/http'
      uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
      Net::HTTP.new('watchout4snakes.com').start { |http|
        return http.post(uri, "").body
      }
    rescue
      return "dan"
    end
  end

end
