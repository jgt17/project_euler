# frozen_string_literal: true

require 'set'
require 'prime'

target = 50_000_000
valid_nums = Set.new
Prime.each do |a|
  Prime.each do |b|
    Prime.each do |c|
      candidate = a**2 + b**3 + c**4
      candidate < target ? valid_nums.add(candidate) : break
    end
    break unless a**2 + b**3 + 16 < target
  end
  break unless a**2 + 24 < target # 24 = 8 + 16 = 2**3 + 2**4
end

p valid_nums.count
