# frozen_string_literal: true

require 'prime'

def four_factors?(num)
  Prime.prime_division(num).length == 4
end

i = 1
i += 1 until (0..3).reduce(true) { |memo, val| memo && four_factors?(i + val)}
p i
