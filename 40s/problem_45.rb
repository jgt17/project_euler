# frozen_string_literal: true

def pentagonal?(num)
  (((1 + Math.sqrt(24.0 * num + 1)) / 6) % 1).zero?
end

def triangular?(num)
  (((-1 + Math.sqrt(8.0 * num + 1)) / 2) % 1).zero?
end

def nth_hexagonal(n)
  n * (2 * n - 1)
end

n = 144
hex = nth_hexagonal(n)
until triangular?(hex) && pentagonal?(hex)
  n += 1
  hex = nth_hexagonal(n)
end

p hex
