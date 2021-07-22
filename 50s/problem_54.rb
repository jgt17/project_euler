# frozen_string_literal: true

# a playing card
class Card
  include Comparable
  attr_reader :rank
  attr_reader :suit

  RANKS = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, 'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }.freeze
  SUITS = { 'C' => 0, 'D' => 1, 'H' => 2, 'S' => 3 }.freeze

  def initialize(char_pair)
    super()
    rank, suit = char_pair.split('')
    @rank = RANKS[rank]
    @suit = SUITS[suit]
  end

  def <=>(other)
    (rank - other.rank).zero? ? 0 : (rank - other.rank) / (rank - other.rank).abs
  end

  def to_s
    @rank.to_s + ' of ' + @suit.to_s
  end
end

# a poker hand
class Hand
  include Comparable
  attr :cards

  def initialize(cp_arr)
    super()
    @cards = cp_arr.map { |cp| Card.new(cp) }.sort.reverse
    determine_hand
  end

  def high_card(cards = @cards)
    Array.new(cards)
  end

  def pair(cards = @cards)
    (0...cards.length - 1).each do |i|
      return cards[i..-1] + cards[0...i] if cards[i] == cards[i + 1] # cards are sorted by rank
    end
    nil
  end

  def two_pair(cards = @cards)
    first_pair = pair(cards)
    return nil if first_pair.nil?

    second_pair = pair(first_pair[2..-1])
    return nil if second_pair.nil?

    first_pair[0..1] + second_pair
  end

  def three_of_a_kind(cards = @cards)
    (0...cards.length - 2).each do |i|
      if cards[i] == cards[i + 1] && cards[i] == cards[i + 2] # cards are sorted by rank
        return cards[i..-1] + cards[0...i]
      end
    end
    nil
  end

  def straight(cards = @cards)
    if cards[0].rank != 14 # aces can be high or low
      (0...cards.length - 1).each do |i|
        return nil unless cards[i].rank - cards[i + 1].rank == 1 # cards are sorted by rank
      end
      Array.new(cards)
    elsif straight(cards[1..-1]) && cards[-1].rank == 2 # low aces case
      cards[1..-1].append cards[0]
    end
  end

  def flush(cards = @cards)
    (0...cards.length - 1).each do |i|
      return nil unless cards[i].suit == cards[i + 1].suit # cards are sorted by rank
    end
    Array.new(cards)
  end

  def full_house(cards = @cards)
    triple = three_of_a_kind(cards)
    return nil if triple.nil?

    pair = pair(triple[3..-1])
    return nil if pair.nil?

    triple[0..2] + pair
  end

  def four_of_a_kind(cards = @cards)
    (0...cards.length - 3).each do |i|
      if cards[i] == cards[i + 1] && cards[i] == cards[i + 2] && cards[i] == cards[i + 3] # cards are sorted by rank
        return cards[i..-1] + cards[0...i]
      end
    end
    nil
  end

  def straight_flush(cards = @cards)
    nil unless straight(cards)

    flush(cards)
  end

  # a royal flush is just a straight flush starting with an ace, don't need a separate check

  def determine_hand
    hand_types = %i[straight_flush four_of_a_kind full_house flush straight three_of_a_kind two_pair pair high_card]
    hand_types.each_with_index do |type, i|
      hand = send(type)
      return [i, hand] unless hand.nil?
    end
  end

  def <=>(other)
    hand = p(determine_hand)
    other_hand = p(other.determine_hand)

    return -(hand[0] <=> other_hand[0]) unless (hand[0] <=> other_hand[0]).zero? # if they have the same type of hand

    (0...hand[1].length).each do |i|
      return hand[1][i] <=> other_hand[1][i] unless (hand[1][i] <=> other_hand[1][i]).zero?
    end
    0
  end

  def to_s
    @cards.to_s
  end
end

hands = File.read('p054_poker.txt').split("\n")[0..5].map { |h| h.split(' ') }.map { |h| [h[0..4], h[5..-1]] }
p hands
p p(hands.map { |h| Hand.new(h[0]) > Hand.new(h[1]) }).reduce(0) { |memo, p1_won| p1_won ? memo + 1 : memo }
