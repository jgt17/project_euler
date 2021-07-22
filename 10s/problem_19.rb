def leap_year?(year)
  (year % 4).zero?
end

def problem_19
  first_of_month_day_of_week = 2
  month_length_non_leap = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  month_length_leap = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  month_length = []
  sundays_on_firsts = 0

  (1901..2000).each do |year|
    month_length = leap_year?(year) ? month_length_leap : month_length_non_leap
    (0..11).each do |month|
      first_of_month_day_of_week = (first_of_month_day_of_week + month_length[month]) % 7
      sundays_on_firsts += 1 if first_of_month_day_of_week.zero?
    end
  end

  puts sundays_on_firsts
end

problem_19
