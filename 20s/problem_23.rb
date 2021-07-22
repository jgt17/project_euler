# frozen_string_literal: true

require 'set'

def divisors(int)
  div = [0]
  (1..int / 2).each { |i| div.append(i) if (int % i).zero? }
  div
end

def abundant?(int)
  divisors(int).reduce(:+) > int
end

def all_relevant_abundant_numbers(max = 28_123)
  (1..max).to_a.keep_if { |i| abundant?(i) }
end

def sums_of_abundant_numbers(max = 28_123)
  abundant_nums = all_relevant_abundant_numbers(max)
  sums = Set.new
  abundant_nums.each { |a| abundant_nums.each { |b| sums.add(a + b) if a + b < 28_123 } }
  sums
end

sums = sums_of_abundant_numbers(28_123)
puts ((1...28_123).to_a.delete_if { |i| sums.include?(i) }).reduce(:+)


