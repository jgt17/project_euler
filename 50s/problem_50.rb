require 'prime'

def num_consecutive_primes(prime)
  trailing_prime = Prime.each_entry.each(1_000_000)
  leading_prime = Prime.each_entry.each(1_000_000)
  running_total = 0
  terms = 0
  while leading_prime.peek < prime
    if running_total == prime
      p prime
      return terms
    end

    if running_total > prime
      running_total -= trailing_prime.next
      terms -= 1
    else
      running_total += leading_prime.next
      terms += 1
    end
  end
  -1
end

p(Prime.each(1_000_000).max_by { |prime| num_consecutive_primes(prime) })
