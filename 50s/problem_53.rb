# frozen_string_literal: true

@factorials = {0 => 1, 1 => 1, 2 => 2}

def factorial(num)
  @factorials[num] || @factorials.store(num, num * factorial(num - 1))
end

p (1..100).map { |n| (1...n).count { |r| factorial(n) / (factorial(r) * factorial(n - r)) > 1_000_000 } }.reduce(:+)
