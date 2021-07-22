# frozen_string_literal: true
def same_digit_multiples(num)
  digits = num.digits
  return false if digits[-1] != 1

  digits.sort!
  (2..6).each.map { |m| (m * num).digits.sort}.reduce(true) { |memo, el| memo && digits.eql?(el) }
end

num = 0
num += 1 until same_digit_multiples(num)
p (1..6).map { |m| m * num }.to_a

