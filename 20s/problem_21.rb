# frozen_string_literal: true

def divisors(num)
  return [num] if num < 2

  div = []
  (1...num).each { |i| div.append(i) if (num % i).zero? }
  div
end

def sum_of_divisors(num)
  divisors(num).reduce(:+)
end

def problem_21
  sums_of_divisors = Array.new(10_000)
  (0...10_000).each { |i| sums_of_divisors[i] = sum_of_divisors(i) }
  sum_of_amicable_numbers = 0
  sums_of_divisors.each_with_index { |val, index| sum_of_amicable_numbers += val if sums_of_divisors[val].eql?(index) and val != index }
  puts sum_of_amicable_numbers
end

problem_21
