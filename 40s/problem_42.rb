# frozen_string_literal: true

def word_value(str)
  str.each_char.map { |char| char.ord - 64 }.reduce(:+)
end

def triangle_num?(int)
  ((-1 + Math.sqrt(8.0 * int + 1)) % 1).zero?
end

p File.read('p042_words.txt').split(/[",]+/)[1..-1].map { |str| triangle_num?(word_value(str)) ? 1 : 0 }.reduce(:+)
