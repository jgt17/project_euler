# frozen_string_literal: true

def fact(n)
  (1..n).reduce(:*) || 1
end

def swap_with_first_el(arr, idx)
  temp = arr[idx]
  arr[idx] = arr[0]
  arr[0] = temp
end

def move_to_front(arr, idx)
  arr.prepend(arr.delete_at(idx))
end

# assumes array is lexicographically sorted
def nth_permutation_helper(arr, num)
  return arr if arr.length.zero?

  less_perms = fact(arr.length - 1)
  move_to_front(arr, num / less_perms)
  nth_permutation_helper(arr[1..-1], num % less_perms).prepend(arr[0])
end

def nth_permutation(arr, num)
  return nil if fact(arr.length) < num - 1

  nth_permutation_helper(arr, num - 1)
end

p nth_permutation([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 1_000_000 )
# (1..6).each { |n| p nth_permutation([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], n)}
