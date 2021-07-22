# frozen_string_literal: true

def palindromic(str)
  (0..str.length / 2).each { |idx| return false unless str[idx].eql? str[-idx - 1] }
  true
end

puts (1..1_000_000).to_a.keep_if { |int| palindromic(int.to_s) && palindromic(int.to_s(2)) }.reduce(:+)



