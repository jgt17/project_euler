# frozen_string_literal: true

# assumes arr1 is A by B, and arr2 is B by C
def dot_product(arr1, arr2)
  arr1 = [arr1] unless arr1[0].is_a? Enumerable
  arr2 = [arr2] unless arr2[0].is_a? Enumerable

  arr1.each_index.map { |i| arr2[0].each_index.map { |k| arr2.each_index.map { |j| arr1[i][j] * arr2[j][k] }.reduce(:+) } }.to_a
end

def scalar_product(arr1, scalar)
  return arr1.map { |el| el * scalar } unless arr1[0].is_a? Enumerable

  arr1.map { |subarray| scalar_product(subarray, scalar) }
end
