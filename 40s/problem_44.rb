# frozen_string_literal: true

require 'set'


def nth_pentagonal(n)
  n * (3 * n - 1) / 2
end

FIRST_N_PENTAGONALS = (1..20_000).map { |i| nth_pentagonal(i) }.to_a
PENTAGONALS = FIRST_N_PENTAGONALS.to_set

def nth_pentagonal_fast(n)
  FIRST_N_PENTAGONALS[n - 1] || nth_pentagonal(n)
end

def pentagonal?(num)
  PENTAGONALS.include?(num) || (((1 + Math.sqrt(24.0 * num + 1)) / 6) % 1).zero? ? PENTAGONALS.add(num) : false
end

def pentagonal_all_the_way?(j, k)
  p_j = nth_pentagonal_fast(j)
  p_k = nth_pentagonal_fast(k)
  # p [j, p_j, k, p_k, pentagonal?(p_j + p_k), pentagonal?(p_k - p_k)]
  pentagonal?(p_j + p_k) && pentagonal?(p_k - p_j)
end

min_d = 1_000_000_000
(1..10_000).each do |n|
  (1..10_000).each do |j|
    diff = nth_pentagonal_fast(j + n) - nth_pentagonal_fast(j)
    if diff < min_d && pentagonal_all_the_way?(j, j + n)
      min_d = p diff
    end
  end
end
p min_d
