require 'prime'

Prime.each(10_000) do |p|
  next if p < 1000

  prime_permutations = p.to_s.split('').permutation.map { |perm| perm.reduce('', &:concat).to_i }.to_a.keep_if { |n| n > 1000 && Prime.prime?(n) }.sort.uniq
  next if prime_permutations.length < 3 || !prime_permutations[0].eql?(p)

  (0..prime_permutations.length - 3).each do |a|
    (a + 1..prime_permutations.length - 2).each do |b|
      if prime_permutations.include?(prime_permutations[b] * 2 - prime_permutations[a])
        p([prime_permutations[a], prime_permutations[b], prime_permutations[b] * 2 - prime_permutations[a]])
      end
    end
  end
end
