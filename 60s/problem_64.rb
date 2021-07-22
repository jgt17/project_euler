# frozen_string_literal: true

def next_numer(num, denom, numer)
  (num - denom**2) / numer
end

def next_denom(num, denom, numer_next)
  Math.sqrt(num).floor - ((Math.sqrt(num).floor + denom) % numer_next)
end

def next_a(num, denom, numer_next)
  (Math.sqrt(num).floor + denom) / numer_next
end

def to_sym(a_n, numer, denom)
  (a_n.to_s + '_' + numer.to_s + '_' + denom.to_s).to_sym
end

def odd_period_root_helper(num, numerator, denominator, fracs_so_far)
  numerator_next = next_numer(num, denominator, numerator)
  return false if numerator_next.zero?  # if numerator_next ever becomes 0, sqrt(num) is rational

  denominator_next = next_denom(num, denominator, numerator_next)
  a_next = next_a(num, denominator, numerator_next)

  a_numer_denom = to_sym(a_next, numerator_next, denominator_next)
  return (fracs_so_far[a_numer_denom] - fracs_so_far.size).odd? if fracs_so_far.key?(a_numer_denom)

  fracs_so_far[a_numer_denom] = fracs_so_far.size
  odd_period_root_helper(num, numerator_next, denominator_next, fracs_so_far)
end

def odd_period_root?(num)
  odd_period_root_helper(num, num, 0, {})
end

p((1..10_000).count { |n| odd_period_root?(n) })
