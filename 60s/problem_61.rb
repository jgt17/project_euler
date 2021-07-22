# frozen_string_literal: true

require 'set'

def triangular?(num)
  (((-1 + Math.sqrt(8 * num + 1)) / 2) % 1).zero?
end

def square?(num)
  ((Math.sqrt num) % 1).zero?
end

def pentagonal?(num)
  (((1 + Math.sqrt(24 * num + 1)) / 6) % 1).zero?
end

def hexagonal?(num)
  (((1 + Math.sqrt(8 * num + 1)) / 4) % 1).zero?
end

def heptagonal?(num)
  (((3 + Math.sqrt(40 * num + 9)) / 10) % 1).zero?
end

# start from octagonal numbers, as there are the fewest of them
def nth_octagonal(nth)
  nth * (3 * nth - 2)
end

def cycle_search(num, options, sum_so_far, last_two_digits)
  return p sum_so_far if options.empty? && num % 100 == last_two_digits

  first_two_digits = (num % 100) * 100
  (first_two_digits + 11..first_two_digits + 99).each do |next_num|
    options.each do |option|
      if send(option, next_num) && next_num > 999
        cycle_search(next_num, Set.new(options).delete(option), sum_so_far + next_num, last_two_digits)
      end
    end
  end
end

def initiate_search
  (21..63).each do |n|
    nth = nth_octagonal(n)
    cycle_search(nth, %i[triangular? square? pentagonal? hexagonal? heptagonal?], nth, nth / 100)
  end
end

initiate_search
