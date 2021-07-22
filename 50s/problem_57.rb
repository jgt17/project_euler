count = 0

fractional_part = Rational(0, 2)
1000.times do
  fractional_part = 1 / (2 + fractional_part)
  expansion = 1 + fractional_part
  count += 1 if expansion.numerator.digits.length > expansion.denominator.digits.length
end

p count
