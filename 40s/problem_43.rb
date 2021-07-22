# frozen_string_literal: false

def sub_string_divisible(arr)
  primes = [2, 3, 5, 7, 11, 13, 17]
  (0..6).each { |i| return false unless (arr[1 + i..3 + i].reduce('', &:concat).to_i % primes[i]).zero? }
  true
end

p %w[0 1 2 3 4 5 6 7 8 9].permutation.reduce(0) { |memo, perm| sub_string_divisible(perm) ? memo + p(perm.reduce('', &:concat).to_i) : memo }
