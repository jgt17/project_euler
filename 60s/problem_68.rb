# frozen_string_literal: true

# arr specs: 0...n: core n-gon, starting at top going clockwise, n..-1: spurs, starting at top going clockwise
# so the example solution shown would be [3, 2, 1, 4, 6, 5]

def magic?(arr)
  n = arr.size / 2
  (0...n).map { |i| (arr[i] + arr[i + 1 < n ? i + 1 : 0] + arr[n + i]) }.reduce { |s, memo| s == memo ? memo : false }
end

def in_print_order(arr)
  print_order = []
  n = arr.size / 2
  (0...n).each { |i| print_order.append(arr[n + i]).append(arr[i]).append(arr[i + 1 < n ? i + 1 : 0]) }
end

def concat(arr)
  arr.map(&:to_s).reduce(:+).to_i
end

n = 5
p((1..2 * n).to_a.permutation.to_a.keep_if { |p| magic?(p) && (1...n).reduce(true) { |memo, i| p[n] < p[n + i] ? memo : false } }.map { |p| concat(in_print_order(p)) }.keep_if { |p| p < 10**16 }.max)
