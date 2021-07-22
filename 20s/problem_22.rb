# frozen_string_literal: true


def name_score(str, index)
  (index + 1) * (str.each_codepoint.reduce { |memo, cp| memo + cp - 64 } - 64)
end

names = File.read('p022_names.txt').split(/[",]+/)
names.delete_at(0)
names.sort!
puts (names.map.with_index { |name, idx| name_score(name, idx) }).reduce(:+)
