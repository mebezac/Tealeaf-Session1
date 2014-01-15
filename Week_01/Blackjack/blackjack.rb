#Blackjack

@card_values_hash = {"Ace" => 1, "Two" => 2, "Three" => 3, "Four" => 4, "Five" => 5, "Six" => 6, "Seven" => 7, "Eight" => 8, "Nine" => 9, "Ten" => 10, "Jack" => 10, "Queen" => 10, "King" => 10}
@deck = []
@player_hand =[]
@deaker_hand =[]
@player_score = 0
@dealer_score = 0

#Create Deck
def create_decks num
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

def card_value card
  @card_values_hash[card.split[0]]
end

def hand_value hand

  value = 0

  hand.each do |card| 
    value += card_value card
  end

  return value

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

  create_decks 5
  shuffle
  @player_hand = []
  @dealer_hand = []

  deal
  @player_score = hand_value @player_hand
  @dealer_score = hand_value @dealer_hand
  puts "#{@name}'s hand: #{@player_hand.join(', ')}, which has a value of: #{@player_score}"
  puts "Dealer's hand: #{@dealer_hand.join(', ')}, which has a value of: #{@dealer_score}"

end

def deal
  
  @player_hand[0] = @deck.pop
  @player_hand[1] = @deck.pop
  @dealer_hand[0] = @deck.pop
  @dealer_hand[1] = @deck.pop

end

def hit hand
  hand.push @deck.pop  
end

def hit_or_stay
  say "Would you like to hit or stay?"
  answer = gets.chomp.downcase

  if answer == 'hit'
    hit @player_hand
    @player_score = hand_value @player_hand
    say "Your hand is now worth #{@player_score}"
    hit_or_stay

  elsif answer == 'stay'
    finalize

  else 
    say "Please enter either hit or stay!"
    hit_or_stay
  end
end

def finalize
  say "Ok, let's see who won!"
  while @dealer_score <= 17
    @dealer_score = hand_value @dealer_hand
    hit @dealer_hand
  end
  say "Ok so the dealer's score is: #{@dealer_score}"
  say "And #{@name}'s score is #{@player_score}"
end

new_game
hit_or_stay

