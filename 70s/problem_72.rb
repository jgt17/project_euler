# frozen_string_literal: true

# require 'set'
require_relative '60s/0s/problem_69'

# reduced_fracs = Set.new
# (2..1_000_000).each { |d| (1..d).each { |n| reduced_fracs.add(Rational(n, d)) } }
# p reduced_fracs.size

# number of reduced fracs for denominator d is equivalent to totient(d)
p((2..1_000_000).map { |d| totient(p(d)) }.reduce(:+))
