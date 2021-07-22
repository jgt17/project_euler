# a**2 + b**2 == c**2, c / (a + b + c) is minimized when a == b at (sqrt(2) - 1) * c
# and c can be no larger than slightly less than half of (a + b + c)
# both a and b must be less than c
# if L_1 is divisible by L_2, then L_1 has at least as many integer solutions as L_2
# if L_1 is divisible by L_2, ... L_n, then L_1 has as many solutions as it has unique divisors
# if L_1 is not divisible by any L_n < L_1, then L_1 may have exactly one solution
# defining that a is the longer of the legs (ie, a > b), a is maximized at slightly less than c,
# and minimized at a == b, ie a == sqrt(2)/2 * c
#
# https://en.wikipedia.org/wiki/Pythagorean_triple gives some insights
# L = k * (m**2 - n**2 + 2*m*n + m**2 + n**2) = 2 * k * m * (m + n), for k, m, n > 0
# m is less than sqrt(max_l / 2)
# n is less than max_l / (2 * m) - , equivalent to n < m
# k is less than max_l / (2 * m * (m + n))

require 'prime'

def coprime?(int_m, int_n)
  Prime.prime_division(int_n).map { |factor, _| !(int_m % factor).zero? }.reduce(true) { |memo, el| memo && el }
end

def primitive_triple?(int_m, int_n)
  !(int_m.odd? && int_n.odd?) && coprime?(int_m, int_n)
end

max_l = 1_500_000
num_solutions = Array.new(max_l + 1, 0)
(1..Math.sqrt(max_l / 2).to_i).each do |m|
  (1...m).each do |n|
    l = 2 * m * (m + n)
    p [l, m, n, m**2 - n**2, 2 * m * n, m**2 + n**2]
    break if l > max_l # continue to next m when n gets too large
    next if (num_solutions[l]).positive? && !primitive_triple?(m, n)

    # ^ ignore a solution that is already a multiple of an existing one, since it's multiples are also accounted for

    (1..(max_l / (2 * m * (m + n)))).each do |k|
      num_solutions[l * k] += 1
    end
  end
end

# p num_solutions
# p (0..max_l).map { |i| i % 10 }.to_a

p(num_solutions.count { |l| l == 1 })
