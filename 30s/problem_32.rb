# frozen_string_literal: true

require 'set'

# could probably make some performance improvements if I needed too

def digits_to_num(arr)
  arr.reduce { |memo, num| memo*10 + num}
end

products = Set.new
digits = [1, 2, 3, 4, 5, 6, 7, 8, 9]
(1...digits.length - 2).each do |a_length|
  digits.permutation(a_length).each do |a_digits|
    (1...digits.length - 1 - a_length).each do |b_length|
      (digits - a_digits).permutation(b_length).each do |b_digits|
        (digits - a_digits - b_digits).permutation(digits.length - a_length - b_length).each do |c_digits|
          products.add(digits_to_num(c_digits)) if digits_to_num(a_digits) * digits_to_num(b_digits) == digits_to_num(c_digits)
        end
      end
    end
  end
end

puts products.reduce(:+)
