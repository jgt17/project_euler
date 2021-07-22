def right_triangle?(a, b, c)
  a**2 + b**2 == c**2
end

def num_solutions(num)
  solutions = 0
  (1..num - 2).each do |a|
    (a..num - a - 1).each do |b|
      solutions += 1 if right_triangle?(a, b, num - a - b)
    end
  end
  solutions
end

max_solutions = 3
max_solutions_num = 120
(12..1000).each do |num|
  solutions_for_num = num_solutions(num)
  if solutions_for_num > max_solutions
    p max_solutions = solutions_for_num
    p max_solutions_num = num
  end
end
