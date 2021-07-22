# frozen_string_literal: true

# drawing on problems 31, 76, and 77
#
# https://mathworld.wolfram.com/PartitionFunctionP.html
#
# p(n) = sum(k = 1..n) of -1**(k+1) * (p(n - k(3k-1)/2) + p(n - k(3k+1)/2))
#
# https://mathworld.wolfram.com/PartitionFunctionq.html
#
# q(n,k) = q(n, k-1) + q(n-k, k)

def partition_q(n, k)
  return @q_values[n][-1] if k > n
  return 0 if k.zero?
  return 1 if n == 1
  return @q_values[n][k] if @q_values[n][k]

  partition_q(n, k - 1) + partition_q(n - k, k)
end

divisible_by = 1_000_000
@q_values = [[1], [0, 1]]
n = 1
loop do
  n += 1
  p n if (n % 1000).zero?
  @q_values.push Array.new(n + 1)
  (0..n).each do |k|
    @q_values[n][k] = partition_q(n, k) % divisible_by
  end
  break if @q_values[n][-1].zero?
end

p n
# p @q_values[n][-2]
