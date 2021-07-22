# frozen_string_literal: true

require 'prime'

# k <= minimum product-sum <= 2k

def all_factorizations(num)
  Prime.prime_division(num)
end
