# frozen_string_literal: true

require 'bigdecimal/util'

def cycle_length(frac)
  matches = BigDecimal(frac, 4096).to_s.match(/(\d+?)\1/)
  matches.nil? ? 0 : matches[-1].length
end

puts((1..1000).max_by { |n| cycle_length(Rational(1, n)) })
