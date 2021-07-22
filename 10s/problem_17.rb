# frozen_string_literal: true

@number_lengths = Hash[0 => 0, 1 => 3, 2 => 3, 3 => 5, 4 => 4, 5 => 4, 6 => 3, 7 => 5, 8 => 5, 9 => 4, 10 => 3,
                       11 => 6, 12 => 6, 13 => 8, 14 => 8, 15 => 7, 16 => 7, 18 => 9, 19 => 8,
                       20 => 6, 30 => 6, 40 => 5, 50 => 5, 60 => 5, 70 => 7, 80 => 6, 90 => 6,
                       100 => 7, 1000 => 8]

def number_length(i, include_and = false)
  return number_length(i / 1000) + @number_lengths[1000] + number_length(i % 1000, true) if i >= 1000
  return number_length(i / 100) + @number_lengths[100] + number_length(i % 100, true) if i >= 100
  return 0 if i.zero?
  return 3 + number_length(i) if include_and

  if @number_lengths.include?(i)
    @number_lengths[i]
  else
    @number_lengths[i / 10 * 10] + @number_lengths[i % 10]
  end
end

def problem_17
  (1..30).each { |i| puts i.to_s + ':  ' + number_length(i).to_s}
  puts number_length(342)
  puts number_length(115)
  puts number_length(1000)

  l = 0
  (1..1000).each { |i| l += number_length(i)}
  puts l
end

problem_17
