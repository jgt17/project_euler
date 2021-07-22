# frozen_string_literal: true

require 'prime'

def primes_produced(a,b, n=1)
  Prime.prime?(n**2 + a*n + b) ? primes_produced(a, b, n+1) : n-1
end

max_a = -999
max_b = -999
max_primes = 0
(-999...1000).each do |a|
  (-999...1000).each do |b|
    primes = primes_produced(a,b)
    next unless primes > max_primes

    max_a = a
    max_b = b
    max_primes = primes
  end
end

puts max_a
puts max_b
puts max_primes
puts max_a * max_b
