def palindromic(num)
  digits = num.digits
  (0..digits.length / 2).each { |i| return false unless digits[i] == digits[-(i + 1)] }

  true
end

def cycle(num, cycles = 0)
  return true if palindromic(num) && cycles.positive?
  return false if cycles > 50

  cycle(num + num.to_s.reverse.to_i, cycles + 1)
end

p cycle(196)
p(p((0..9999).each.map { |i| cycle(i) }).reduce(0) { |memo, nl| nl ? memo : memo + 1 })
