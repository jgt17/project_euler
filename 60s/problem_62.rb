# frozen_string_literal: true

# attempt 1, n was large enough that runtime blew up for anything beyond 3 permutations
# p((1..).find { |n| (n**3).to_s.split('').permutation.reject { |perm| perm[0].eql?('0') }.map { |perm| perm.reduce(:+).to_i }.uniq.count { |i| (Math.cbrt(i) % 1).zero? } >= 5 }**3)

require 'set'

def n_permutations_also_cube(n_perms)
  permutation_digits = {}
  (1..).each do |n|
    digits = (n**3).to_s.split('').sort.reduce(:+).to_sym
    permutation_digits.key?(digits) ? permutation_digits[digits].add(n) : permutation_digits[digits] = Set[n]
    return permutation_digits[digits].min**3 if permutation_digits[digits].size >= n_perms
  end
end

p n_permutations_also_cube(5)
