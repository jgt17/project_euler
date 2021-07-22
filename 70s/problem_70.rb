# frozen_string_literal: true

require_relative '60s/0s/problem_69'

def to_sorted_sym(num)
  num.to_s.split('').sort.reduce(:+).to_sym
end

def permutations?(num1, num2)
  to_sorted_sym(num1).eql?(to_sorted_sym(num2))
end

p((2...10**7).to_a.keep_if { |i| permutations?(p(i), totient(i)) }.min_by { |i| i.to_f / totient(i) })
