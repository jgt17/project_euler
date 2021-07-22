# frozen_string_literal: true

# p((1..1000).reject { |d| (Math.sqrt(d) % 1).zero? || d == 61 }.max_by { |d| p(((2..).find { |y| (Math.sqrt(d * y**2 + 1.0) % 1).zero? })**2 + 1, d) })
# too slow

# additional research led to Pell equations, and solving them with the continued fraction representation of sqrt(D)

def next_numer(num, denom, numer)
  (num - denom**2) / numer
end

def next_denom(num, denom, numer_next)
  Math.sqrt(num).floor - ((Math.sqrt(num).floor + denom) % numer_next)
end

def next_a(num, denom, numer_next)
  (Math.sqrt(num).floor + denom) / numer_next
end

def solution?(d, x, y)
  x**2 - d * y**2 == 1 && y > 0
end

def minimum_x_helper(d, numerator, denominator, hn_1, hn_2, kn_1, kn_2)
  return hn_1 if solution?(d, hn_1, kn_1)

  numerator_next = next_numer(d, denominator, numerator)
  denominator_next = next_denom(d, denominator, numerator_next)
  a_next = next_a(d, denominator, numerator_next)
  minimum_x_helper(d, numerator_next, denominator_next, a_next * hn_1 + hn_2, hn_1, a_next * kn_1 + kn_2, kn_1)
end

def minimum_x(d)
  minimum_x_helper(d, d, 0, 1, 0, 0, 1)
end

p((1..1000).reject { |d| (Math.sqrt(d) % 1).zero? }.max_by { |d| minimum_x(d) })
