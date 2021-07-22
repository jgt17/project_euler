# frozen_string_literal: true

# the fraction will be the largest fraction with denominator d that is less than 3/7ths, which is floor(((d*3)-1)/7)
p p((1..1_000_000).map { |d| Rational(((d * 3) - 1) / 7, d) }.max).numerator
