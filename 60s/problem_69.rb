# frozen_string_literal: true

require 'prime'
require 'set'

def factors(num)
  num.zero? ? [] : Prime.prime_division(num)
end

@totients = { 1 => 1 }

def totient(num)
  return @totients[num] if @totients.key? num
  return @totients[num] = num - 1 if Prime.prime? num

  factors_of_num = factors(num)
  @totients[num] = if factors_of_num.size > 1
                     totient_of_composite(factors_of_num)
                   else
                     totient_of_p_k(factors_of_num[0][0], factors_of_num[0][1])
                   end
end

def totient_of_composite(factors_of_num)
  factors_of_num.map { |prime, power| totient(prime**power) }.reduce(:*) # phi(mn) = phi(m)phi(n)
end

def totient_of_p_k(prime, pow_k)
  ((prime**pow_k) * (1 - 1 / Rational(prime))).to_i
end

# p((1..1_000_000).max_by { |i| i.to_f / totient(i) })
