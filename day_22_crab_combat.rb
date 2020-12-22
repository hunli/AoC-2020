require 'set'

class Player
  def initialize(input = nil)
    return if input.nil?
    @deck = input.split("\n")[1..-1].map(&:to_i)
  end

  def has_card?
    !@deck.empty?
  end

  def get_card
    @deck.shift
  end

  def insert_cards(*cards)
    @deck += cards
  end

  def get_deck
    @deck.clone
  end

  def set_deck(deck)
    @deck = deck
    self
  end

  def deck_value
    @deck.reverse.each_with_index.sum do |card, index|
      card.to_i * (index + 1)
    end
  end
end

def initialize_players(input)
  p1 = Player.new(input[0])
  p2 = Player.new(input[1])
  [p1, p2]
end

def get_deck_value(player1, player2)
  [player1.deck_value, player2.deck_value].max
end

def insert_cards(player1, player2, card1, card2, player1_win)
  if player1_win
    player1.insert_cards(card1, card2)
  else
    player2.insert_cards(card2, card1)
  end
end

def play_game(player1, player2, enable_subgame)
  history = Set.new

  while player1.has_card? && player2.has_card?
    round_key = [player1.get_deck, player2.get_deck]
    if history.include?(round_key)
      return -1
    else
      history << round_key
    end

    card1 = player1.get_card
    card2 = player2.get_card

    if enable_subgame && (card1 <= player1.get_deck.length && card2 <= player2.get_deck.length)
      result = play_game(Player.new.set_deck(player1.get_deck[0...card1]), Player.new.set_deck(player2.get_deck[0...card2]), enable_subgame)
      insert_cards(player1, player2, card1, card2, result == -1)
    else
      insert_cards(player1, player2, card1, card2, card1 > card2)
    end
  end

  player1.has_card? ? -1 : 1
end

def part1(input, enable_subgame = false)
  player1, player2 = initialize_players(input)
  play_game(player1, player2, enable_subgame)
  get_deck_value(player1, player2)
end

def part2(input)
  part1(input, true)
end

input = [
  "Player 1:
  14
  23
  6
  16
  46
  24
  13
  25
  17
  4
  31
  7
  1
  47
  15
  9
  50
  3
  30
  37
  43
  10
  28
  33
  32",
  "Player 2:
  29
  49
  11
  42
  35
  18
  39
  40
  36
  19
  48
  22
  2
  20
  26
  8
  12
  44
  45
  21
  38
  41
  34
  5
  27"
]

dummy_input = [
  "Player 1:
  9
  2
  6
  3
  1",
  "Player 2:
  5
  8
  4
  7
  10"
]

p "Part 1: #{part1(input)}"
p "Part 2: #{part2(input)}"
