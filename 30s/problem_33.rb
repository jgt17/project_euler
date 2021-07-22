def deceptive_fraction?(a, b, c)
  Rational(10 * a + b, 10 * b + c) == Rational(a, c)
end
product = Rational(1)
(1..9).each { |a| (1..9).each { |b| (1..9).each { |c| product *= Rational(a, c) if deceptive_fraction?(a, b, c) } } }
puts product
