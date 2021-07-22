# frozen_string_literal: true

# the base must be 1-9, inclusive. for b >= 10, digits increase faster than power
# digits in b**n / n decreases for b in 1-9 as n increases

n_digit_nth_powers = 0
(1..9).each do |b|
  (1..).each do |n|
    num_digits = (b**n).to_s.size
    break unless num_digits >= n

    n_digit_nth_powers += 1 if num_digits == n
  end
end

p n_digit_nth_powers
