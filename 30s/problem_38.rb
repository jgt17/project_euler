# frozen_string_literal: true

def pandigital?(str)
  str.length == 9 && (1..9).to_a.reduce { |memo, el| memo && str.include?(el.to_s) }
end

def pcp_helper(num, n, prod)
  return prod.to_i if pandigital?(prod) && n > 1
  return -1 if prod.length > 9

  pcp_helper(num, n + 1, prod + (num * n).to_s)
end

def pandigital_concat_product(num)
  pcp_helper(num, 1, '')
end

def max(a, b)
  a > b ? a : p(b)
end

# took longer than i cared to wait to actually finish finish,
# but produced what ended up being the right answer in less than a second
max_pcp = 0
(1..1_000_000_000 / 3).each { |num| max_pcp = max(max_pcp, pandigital_concat_product(num)) }
p max_pcp
