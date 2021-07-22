def problem_25
  a = 1
  b = 1
  i = 2

  while b < 10**999
    temp = b
    b += a
    a = temp
    i += 1
  end
  puts i
end

problem_25