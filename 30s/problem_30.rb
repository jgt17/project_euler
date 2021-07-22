# frozen_string_literal: true

def max_to_check(pow)
  i = 1
  i += 1 until 10**i > (9**pow) * i
  (9**pow) * i
end

def sum_of_sums_of_power_of_digits(pow)
  p((2..max_to_check(pow)).to_a.keep_if { |n| n.to_s.each_char.map(&:to_i).map { |digit| digit**pow }.reduce(:+) == n }).reduce(:+)

end

puts sum_of_sums_of_power_of_digits 5
