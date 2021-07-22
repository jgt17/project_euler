# frozen_string_literal: true

def nth_partial_component(nth_place)
  return 2 if nth_place == 1

  (nth_place % 3).zero? ? ((nth_place / 3)) * 2 : 1
end

def make_partial_fraction(target_depth, depth = 1)
  return Rational(nth_partial_component(depth)) if target_depth == depth

  nth_partial_component(depth) + Rational(1, make_partial_fraction(target_depth, depth + 1))
end

p p(make_partial_fraction(100)).numerator.digits.reduce(:+)
