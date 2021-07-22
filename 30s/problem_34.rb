# frozen_string_literal: true

def max_to_check()
  i = 1
  i += 1 until 10**i > fact(9) * i
  fact(9) * i
end

def fact(num)
  num <= 1 ? 1 : fact(num - 1) * num
end

puts max_to_check
puts (3..max_to_check).to_a.keep_if { |n| n.to_s.split('').map { |d| fact(d.to_i) }.reduce(:+) == n }.reduce(:+)
