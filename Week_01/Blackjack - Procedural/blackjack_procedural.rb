#Blackjack


@card_values_hash = {"Ace" => 1, "Two" => 2, "Three" => 3, "Four" => 4, "Five" => 5, "Six" => 6, "Seven" => 7, "Eight" => 8, "Nine" => 9, "Ten" => 10, "Jack" => 10, "Queen" => 10, "King" => 10}
@deck = []
@player_hand =[]
@deaker_hand =[]
@player_score = 0
@dealer_score = 0
@player_wins = 0
@dealer_wins = 0
@number_of_games = 0
@who_won = ""

#Create Deck
def create_decks (num)
  suits = ["Clubs", "Spades", "Diamonds", "Hearts"]
  cards = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
  num.times do 
    cards.each do |card|
      suits.each do |suit|
        @deck.push card + " of " + suit
      end
    end 
  end
end

def say (msg)
  puts "=> #{msg}"
end

def scoreboard
  puts ""
  puts "#~#~#~#~#~#~#~#Scoreboard#~#~#~#~#~#~#~#"
  puts "After #{@number_of_games} game(s), the score is:"
  puts "#{@name} : #{@player_wins} ||||||| Dealer : #{@dealer_wins}"
  puts "#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#~#"
end

def card_value (card)
  @card_values_hash[card.split[0]]
end

def hand_value (hand)
  value = 0
  hand.each do |card| 
    value += card_value card
  end

  cards = []
  hand_has_ace = false
  hand.each do |card|
    cards.push card.split[0]
  end
  if cards.include? "Ace"
    hand_has_ace = true
  else
    hand_has_ace = false
  end

  if hand_has_ace && (value + 10) <= 21
    value += 10
    return value
  else
    return value
  end
end

def shuffle
  @deck.shuffle!
end


def new_game
  puts ""
  puts ""
  puts ""
  puts "#-#-#-#-#-#-#-#-#-#-#-#-#Blackjack!#-#-#-#-#-#-#-#-#-#-#-#-#"
  say "Hello, what is your name?"
  @name = gets.chomp
  say "Nice to meet you #{@name}, lets play some Blackjack!"
  start_game

end

def start_game
  create_decks (5)
  shuffle
  @player_hand = []
  @dealer_hand = []

  deal
  @player_score = hand_value (@player_hand)
  @dealer_score = hand_value (@dealer_hand)
  say "#{@name}'s hand: #{@player_hand.join(', ')}, which has a value of: #{@player_score}"
  say "Dealer is showing #{@dealer_hand[0]}"
  hit_or_stay
end

def deal
  
  @player_hand[0] = @deck.pop
  @player_hand[1] = @deck.pop
  @dealer_hand[0] = @deck.pop
  @dealer_hand[1] = @deck.pop

end

def hit (hand)
  hand.push @deck.pop  
end

def press_enter
  say "Press enter to continue"
  gets
end

def hit_or_stay

  if @player_score > 21
    say "Sorry #{@name} you busted."
    @who_won = "the Dealer"
    press_enter
    end_game

  elsif @player_score == 21
    say "#{@name} got a Blackjack!"
    @who_won = "#{@name}"
    press_enter
    end_game

  elsif @player_score <= 21

    say "Would you like to hit or stay, #{@name}?"
    answer = gets.chomp.downcase

    if answer == 'hit' && @player_score <= 21
      hit (@player_hand)
      @player_score = hand_value (@player_hand)
      say "#{@name}'s hand: #{@player_hand.join(', ')}"
      say "#{@name}'s' hand is now worth #{@player_score}"
      hit_or_stay

    elsif answer == 'stay'
      finalize

    else 
      say "#{@name}, Please enter either hit or stay!"
      hit_or_stay
    end
  end
end

def finalize
  say ""
  say "Dealer's hand: #{@dealer_hand.join(', ')}"

  if @dealer_score == 21
    say "The dealer has a blackjack!"
    @who_won = 'the Dealer'
    press_enter
    end_game

  elsif @dealer_score > 21
    say "Dealer's hand #{@dealer_hand.join(', ')}, value: #{@dealer_score}"
    say "The Dealer busted!"
    @who_won = "#{@name}"
    press_enter
    end_game

  elsif @dealer_score >= 17
    say "The Dealer stays because his hand is worth #{@dealer_score}"
    press_enter
    if @dealer_score >= @player_score
      @who_won = "the Dealer"
    else
      @who_won = "#{@name}"
    end
    end_game

  elsif @dealer_score < 17
    say "The dealer will hit because his hand is worth #{@dealer_score}, press enter to continue"
    gets
    hit (@dealer_hand)
    @dealer_score = hand_value @dealer_hand
    say "Dealer's hand: #{@dealer_hand.join(', ')}, value: #{@dealer_score}"
    finalize
  end
  
end

def end_game
  @number_of_games += 1
  puts ""
  say "Ok, let's see who won!"
  puts "Dealer's hand: #{@dealer_hand.join(', ')}, which has a value of: #{@dealer_score}"
  say "Ok so the dealer's score is: #{@dealer_score}"
  say "And #{@name}'s score is #{@player_score}"
  say "So, #{@who_won} won!"

  if @who_won == "the Dealer"
    @dealer_wins += 1
  else
    @player_wins += 1
  end
  press_enter
  scoreboard
  play_again
end

def play_again
  say ""
  say "So, would you like to play again, quit, or clear the scoreboard and keep playing?"
  say "To play again, enter 1"
  say "To quit, enter 2"
  say "To clear the scoreboard and keep playing, enter 3"

  answer = gets.chomp

  if answer == '1' || answer == '2' || answer == '3'
    if answer == '1'
      start_game
    elsif answer == '2'
      say "Have a nice day, #{@name}"
    elsif answer == '3'
      @dealer_wins = 0
      @player_wins = 0
      @number_of_games = 0
      start_game
    end
  else
    say "#{@name}, please enter a valid choice, 1, 2, or 3"
    play_again
  end
end

new_game
