@non_repeating_chain_length = { 169 => 3, 363_601 => 3, 1454 => 3,
                                871 => 2, 43_361 => 2,
                                872 => 2, 45_362 => 2}
@factorials_lookup = { 0 => 1, 1 => 1, 2 => 2, 3 => 6, 4 => 24, 5 => 120,
                       6 => 720, 7 => 5040, 8 => 40_320, 9 => 362_880 }

# only need factorial of 0-9
def factorial(num)
  @factorials_lookup[num]
  # @factorials_lookup.key? num ? @factorials_lookup[num] : @factorials_lookup[num] = num * factorial(num - 1)
end

def sum_of_digits_factorial(num)
  num.to_s.split('').map(&:to_i).map { |d| factorial(d) }.reduce(:+)
end

def chain_length(num)
  if @non_repeating_chain_length.key? num
    @non_repeating_chain_length[num]
  else
    next_num = sum_of_digits_factorial(num)
    @non_repeating_chain_length[num] = next_num.eql?(num) ? 1 : 1 + chain_length(sum_of_digits_factorial(num))
  end
end

p (1...1_000_000).count { |i| chain_length(i) == 60 }
