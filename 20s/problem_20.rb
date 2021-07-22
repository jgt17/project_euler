def problem_20
  puts (1..100).reduce(:*).to_s.chars.map(&:to_i).reduce(:+)
end

problem_20
