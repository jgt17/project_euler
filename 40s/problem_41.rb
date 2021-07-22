# frozen_string_literal: true

require 'prime'

def n_pandigital?(str)
  return false unless str.length < 10

  (1..str.length).each { |el| return false unless str.include?(el.to_s) }
  true
end

max_pandigital_prime = 2143
Prime.each(1_000_000_000) { |prime| max_pandigital_prime = p prime if n_pandigital?(prime.to_s) }
p max_pandigital_prime
