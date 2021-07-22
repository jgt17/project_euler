def sum_of_diagonals(spiral_radius)
  return 1 if spiral_radius < 1

  sum = 1
  side_size = 2
  corner = 1
  spiral_radius.times do
    4.times do
      corner += side_size
      sum += corner
    end
    side_size += 2
  end
  sum
end

puts sum_of_diagonals 500
