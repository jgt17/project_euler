# frozen_string_literal: true

# see also problem 31 for simpler equivalent problem
# and problem 77 for a similar one but with primes

def num_sums(target)
  @partial_num_sums = Array.new(target + 1) { Array.new(target + 1, nil) }
  sums = num_sums_helper(target) - 1
  @partial_num_sums = nil
  sums
end

def num_sums_helper(target, next_num_to_add = 1)
  return base_case(target) if target <= 0 || next_num_to_add > target
  return @partial_num_sums[target][next_num_to_add] if @partial_num_sums[target][next_num_to_add]

  @partial_num_sums[target][next_num_to_add] = (0..target / next_num_to_add).map do |copies|
    num_sums_helper(target - next_num_to_add * copies, next_num_to_add + 1)
  end.reduce(:+)
end

def base_case(target)
  target.zero? ? 1 : 0
end

p num_sums 100
