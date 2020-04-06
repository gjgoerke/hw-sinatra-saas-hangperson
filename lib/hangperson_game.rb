class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @word_with_guesses = "" 
    @word.length.times {@word_with_guesses << "-"}
    @check_win_or_lose = :play
    @guess_count = 0
  end

    attr_accessor :word
    attr_accessor :guesses
    attr_accessor :wrong_guesses
    attr_accessor :word_with_guesses
    attr_accessor :check_win_or_lose
    attr_accessor :guess_count


  def guess(g)
    raise ArgumentError, 'Fix that arg' unless !['','%',nil].include? g
    if !(wrong_guesses.downcase.include?(g.downcase) || guesses.downcase.include?(g.downcase))then
        @guess_count += 1
        if @guess_count == 7
            @check_win_or_lose = :lose
        end
        if word.downcase.include?(g.downcase) then
            @guesses << g
            update_word_with_guesses()
            if @word == @word_with_guesses then 
                @check_win_or_lose = :win
            end
        else
            @wrong_guesses << g
        end
    else 
        return false
    end
  end

  def update_word_with_guesses()
    for c in @guesses.split('')
        indices = @word.gsub(/#{c}/).map { Regexp.last_match.begin(0) }
        for i in indices
            (@word_with_guesses[i] = c) unless @word_with_guesses[i] == c
        end
    end
  end



  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
