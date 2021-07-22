require 'prime'

def prime_on_diagonal_density
  side_size = 4
  corner = 9
  primes = 3.0
  until primes / (2 * side_size - 3) < 0.1
    4.times do
      corner += side_size
      primes += 1 if Prime.prime?(corner)
    end
    side_size += 2
  end
  side_size - 1
end

p prime_on_diagonal_density
