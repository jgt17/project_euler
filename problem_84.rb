# frozen_string_literal: true

require_relative 'util/array_util'

# ignore triple doubles

BOARD_LABELS = %w[go_ a1 cc1 a2 t1 r1 b1 ch1 b2 b3 jail_ c1 u1 c2 c3 r2 d1 cc2 d2 d3
                  fp_ e1 ch2 e2 e3 r3 f1 f2 u2 f3 g2j g1 g2 cc3 g3 r4 ch3 h1 t2 h2].freeze

COMMUNITY_CHEST_CARDS = 16
COMMUNITY_CHEST_MOVE_CHANCE = { 'go' => Rational(1) / COMMUNITY_CHEST_CARDS,
                                'jail' => Rational(1) / COMMUNITY_CHEST_CARDS }.freeze

CHANCE_CARDS = 16
CHANCE_MOVE_CHANCE = { 'go' => Rational(1) / CHANCE_CARDS,
                       'jail' => Rational(1) / CHANCE_CARDS,
                       'c1' => Rational(1) / CHANCE_CARDS,
                       'e3' => Rational(1) / CHANCE_CARDS,
                       'h2' => Rational(1) / CHANCE_CARDS,
                       'r1' => Rational(1) / CHANCE_CARDS,
                       'next_r' => Rational(2) / CHANCE_CARDS,
                       'next_u' => Rational(1) / CHANCE_CARDS,
                       'back_3' => Rational(1) / CHANCE_CARDS }.freeze

def modifiers
  modifiers = Array.new(BOARD_LABELS.size) { Array.new(BOARD_LABELS.size, 0) }
  jail_index = BOARD_LABELS.find_index { |el| el.match?(/(jail)/) }
  BOARD_LABELS.each_with_index do |label, index|
    if label.match?(/(cc)/)
      modifiers[index] = modifier_row(COMMUNITY_CHEST_MOVE_CHANCE, index)
    elsif label.match?(/(ch)/)
      modifiers[index] = modifier_row(CHANCE_MOVE_CHANCE, index)
    elsif label.match?(/(g2j)/)
      modifiers[index][jail_index] = Rational(1)
      modifiers[index][index] = Rational(0)
    else
      modifiers[index][index] = Rational(1)
    end
    p modifiers[index]
    # chance of going to jail on doubles
    modifiers[index] = scalar_product(modifiers[index], Rational(215, 216))
    modifiers[index][jail_index] += Rational(1, 216)
  end
  modifiers
end

def modifier_row(chances_of_move_to, draw_index)
  row = Array.new(BOARD_LABELS.size, Rational(0))
  chances_of_move_to.each do |key, value|
    if key.match?(/(next_)/)
      row[next_space(draw_index, key[-1])] += chances_of_move_to[key]
    elsif key.match?(/(back_)/)
      row[(draw_index - 3) % BOARD_LABELS.size] += chances_of_move_to[key]
    else
      BOARD_LABELS.each_with_index do |label, index|
        break row[index] += value if label.match? key
      end
    end
  end
  row[draw_index] += 1 - chances_of_move_to.each_value.reduce(:+)
  row
end

def next_space(start_index, next_what)
  (start_index..start_index + BOARD_LABELS.size).each do |end_index|
    return end_index % BOARD_LABELS.size if BOARD_LABELS[end_index % BOARD_LABELS.size].match? next_what
  end
end

def move_distance_distribution(die_size)
  (2..2 * die_size).map { |x| p Rational(die_size - (x - die_size - 1).abs) / Rational(die_size**2) }.prepend(Rational(0)).prepend(Rational(0))
end

def apply_dice_roll(probabilities)
  next_probabilities = Array.new(probabilities.size, Rational(0))
  probabilities.each_index do |i|
    ROLLS.each_index do |j|
      next_probabilities[(i + j) % BOARD_LABELS.size] += probabilities[i] * ROLLS[j]
    end
  end
  dot_product(next_probabilities, MODIFIERS)[0]
end

MODIFIERS = modifiers.freeze
ROLLS = move_distance_distribution(4).freeze

modifiers.each { |r| p r }

# first dimension reflects the last two rolls being not doubles, one double, two doubles
probabilities = Array.new(BOARD_LABELS.size, Rational(0))
probabilities[0] = Rational(1)

200.times { probabilities = apply_dice_roll(probabilities) }
p probabilities.map(&:to_f).zip(BOARD_LABELS) #.sort_by { |p, l| p }
p(p(probabilities.map!(&:to_f).max(3)).map { |el| probabilities.find_index(el) })
