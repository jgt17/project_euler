# frozen_string_literal: false

# screw it, brute force it is
# i'm sure there's a mathematical shortcut, but i just need the one solution, so performance doesn't matter

irrational_decimals = ''
(1..1_000_000).each do |i|
  irrational_decimals.concat(i.to_s)
  break unless irrational_decimals.length < 1_000_000
end

product_of_digits = 1
(0..6).each do |i|
  product_of_digits *= irrational_decimals[10**i - 1].to_i
end
p product_of_digits
