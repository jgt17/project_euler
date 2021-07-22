# frozen_string_literal: true

# drawing on problems 76 and 31
# see also 78

require 'prime'

def first_num_with_n_sums(int_n)
  prime_generator = Prime::EratosthenesGenerator.new
  @primes = [prime_generator.next]
  @partial_num_sums = [[]]

  (1..).find do |i|
    @primes.push prime_generator.next while @primes[-1] < i
    @partial_num_sums.push Array.new(@primes.length)
    num_prime_sums(i, 0) - (Prime.prime?(i) ? 1 : 0) >= int_n
  end
end

def num_prime_sums(target, prime_index)
  return base_case(target) if target <= 0 || prime_index >= @primes.size # || @primes[prime_index] > target
  return @partial_num_sums[target][prime_index] if @partial_num_sums[target][prime_index]

  @partial_num_sums[target][prime_index] = (0..target / @primes[prime_index]).map do |copies|
    num_prime_sums_with_copies(target, prime_index, copies)
  end.reduce(:+)
end

def num_prime_sums_with_copies(target, prime_index, copies)
  num_prime_sums(target - @primes[prime_index] * copies, prime_index + 1)
end

def base_case(target)
  target.zero? ? 1 : 0
end

p first_num_with_n_sums(5000)
