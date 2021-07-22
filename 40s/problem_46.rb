require 'prime'

def breaks_the_conjecture(num)
  Prime.each(num) { |p| (1..Math.sqrt(num / 2).floor).each { |sqr| return false if p + 2 * sqr**2 == num} }
  true
end

n = 9
n += 2 until !Prime.prime?(n) && breaks_the_conjecture(n)
p n
