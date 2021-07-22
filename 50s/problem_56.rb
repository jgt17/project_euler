p (0..99).each.map { |a| (0..99).each.map { |b| (a**b).digits.reduce(:+) }.max }.max
