# frozen_string_literal: true

require 'prime'

def truncatable_prime_left(prime)
  return true if prime.zero?
  return false unless Prime.prime?(prime)

  truncatable_prime_left(prime % 10**Math.log10(prime).floor)
end

def truncatable_prime_right(prime)
  return true if prime.zero?
  return false unless Prime.prime?(prime)

  truncatable_prime_right(prime / 10)
end

double_truncatable_primes = []
Prime.each do |prime|
  p double_truncatable_primes.push(prime) if prime > 10 && truncatable_prime_left(prime) && truncatable_prime_right(prime)
  break unless double_truncatable_primes.size < 11
end
p double_truncatable_primes.reduce(:+)
