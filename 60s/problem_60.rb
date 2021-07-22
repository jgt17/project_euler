# frozen_string_literal: true

require 'prime'
require 'set'

@concat_sets = []
@double_set_each = ->(set_a, set_b, block) { set_a.each { |el_a| set_b.each { |el_b| block.call(el_a, el_b) } } }
@primes = Prime.each

def concats_are_prime(prime_a, prime_b)
  concat_prime = ->(a, b) {(a.to_s + b.to_s).to_i.prime? }
  concat_prime.call(prime_a, prime_b) && concat_prime.call(prime_b, prime_a)
end

def prime_concat_pairs(new_prime)
  ([new_prime].product Prime.each(new_prime - 1).to_a[1..-1]).keep_if { |pair| concats_are_prime(*pair) }.map(&:to_set)
end

def mergeable(pairs, new_prime, extant_set)
  extant_set.each do |p|
    return false unless pairs.include? Set[new_prime, p]
  end

  true
end

def add_prime(prime)
  pairs = prime_concat_pairs(prime)
  @concat_sets.each { |con_set| @concat_sets.append(Set.new(con_set).add(prime)) if mergeable(pairs, prime, con_set) }
  @concat_sets.append(*pairs)
end

def find_set(num_primes)
  add_prime(@primes.next) until @concat_sets.count { |s| s.size >= num_primes }.positive?

  @concat_sets.find { |s| s.size >= num_primes }
end

@primes.next # start at 3
p p(find_set(5)).to_a.reduce(:+)
