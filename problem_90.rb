# frozen_string_literal: true

require 'set'

def squares_from_cubes?(cube1, cube2, squares)
  squares.each { |square| return false unless square_from_cubes?(cube1, cube2, square) }
  true
end

def square_from_cubes?(cube1, cube2, square)
  cube1.each do |side1|
    cube2.each do |side2|
      return true if [side1 + side2, side2 + side1].include? square
    end
  end
  false
end

squares = (1..9).map { |i| format('%02d', i**2) }.to_a
cube_pairs = Set.new
(0..9).to_a.combination(6) do |cube1|
  cube1.add '9' if cube1.include?('6') && !cube1.include?('9')
  cube1.add '6' if cube1.include?('9') && !cube1.include?('6')
  (0..9).to_a.combination(6) do |cube2|
    cube2.add '9' if cube2.include?('6') && !cube2.include?('9')
    cube2.add '6' if cube2.include?('9') && !cube2.include?('6')
    cube_pairs.add(Set.new([cube1, cube2])) if squares_from_cubes?(cube1, cube2, squares)
  end
end

p cube_pairs.size
