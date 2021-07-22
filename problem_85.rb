# frozen_string_literal: true

def num_rectangles(size_x, size_y, sub_x, sub_y)
  (size_x - sub_x + 1) * (size_y - sub_y + 1)
end

def total_rectangles(size_x, size_y)
  (1..size_x).map { |sub_x| (1..size_y).map { |sub_y| num_rectangles(size_x, size_y, sub_x, sub_y) }.reduce(:+) }.reduce(:+)
end

def find_closest_dimensions(target)
  closest_x = 0
  closest_y = 0
  best_difference = target
  (1..).each do |x|
    (1..x).each do |y| # problem is symmetric about x == y
      rects = total_rectangles(x, y)
      difference = (rects - target).abs
      if difference < best_difference
        best_difference = difference
        closest_x = x
        closest_y = y
      end

      return [closest_x, closest_y] if rects > target && y == 1
      break if rects > target
    end
  end
end

p(p(find_closest_dimensions(2_000_000)).reduce(:*))
