# frozen_string_literal: true

require 'set'
require 'prime'

def rotations(num)
  rotated = Set.new
  power_of_ten = Math.log10(num).floor
  until rotated.include?(num)
    rotated.add(num)
    num = (num % 10**power_of_ten) * 10 + num / 10**power_of_ten
  end
  rotated
end

primes = Set.new(Prime.each(1_000_000))
circular_primes_count = 0
primes.each do |p|
  circular_primes_count += 1 if rotations(p).subset? primes
end
puts circular_primes_count
