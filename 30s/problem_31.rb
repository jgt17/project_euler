coins = [1, 2, 5, 10, 20, 50, 100, 200]
target = 200

# could dramatically improve performance by keeping a lookup table for previously solved targets,
# but I only need the one case for the problem
# see problem 76 for a similar approach with more optimization
def combo_counter(coins, target)
  return 1 if target.zero?
  return 0 if target.negative? || coins.empty?

  coin = coins[0]
  (0..target / coin).map { |num| combo_counter(coins[1..-1], target - coin * num) }.reduce(:+)
end

puts combo_counter(coins, target)
