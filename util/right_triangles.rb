# frozen_string_literal: true

require 'set'

# seeing as right triangles keep coming up, figured I should make it easier to find and work with them

def right_triangle?(side_a, side_b, side_c)
  side_a**2 + side_b**2 == side_c**2
end

def generate_triples(max_leg: nil, max_hypotenuse: nil, max_perimeter: nil)
  max_leg, max_hypotenuse, max_perimeter = derive_missing_params(max_leg, max_hypotenuse, max_perimeter)
  generate_triples_known_limits(max_leg, max_hypotenuse, max_perimeter)
end

def euclids_formula(int_m, int_n)
  triple = [int_m**2 - int_n**2, 2 * int_m * int_n, int_m**2 + int_n**2, 2 * int_m * (int_m + int_n)].sort
  int_m.odd? && int_n.odd? ? triple.map { |el| el / 2 } : triple
end

private

# fill in missing parameters for generating right triangles with rough upper bounds
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity
def derive_missing_params(leg, hypot, perim)
  provided_params = [leg, hypot, perim].reduce('p') { |memo, param| memo + (param ? '1' : '0') }.to_sym
  case provided_params
  when :p001
    [perim / 2, perim / 2, perim]
  when :p010
    [hypot, hypot, (hypot * (1 + Math.sqrt(2))).ceil]
  when :p011
    [perim - hypot - 1, hypot, perim]
  when :p100
    [leg, (Math.sqrt(2) * leg).ceil, ((2 + Math.sqrt(2)) * leg).ceil]
  when :p101
    [leg, [(Math.sqrt(2) * leg).ceil, perim - leg - 1].min, perim]
  when :p110
    [leg, hypot, 2 * leg + hypot]
  else
    [leg, hypot, perim]
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity

# rubocop:disable Metrics/ParameterLists
def in_bounds?(side_a, side_b, side_c, perim, max_leg, max_hypot, max_perim)
  perim <= max_perim && side_a <= max_leg && side_b <= max_leg && side_c <= max_hypot
end

def scale_limit(leg, hypot, perim, max_leg, max_hypot, max_perim)
  [max_perim / perim, max_leg / leg, max_hypot / hypot].min
end
# rubocop:enable Metrics/ParameterLists

def scaled_triples(side_a, side_b, side_c, up_to)
  (1..up_to).map { |k| [side_a * k, side_b * k, side_c * k] }
end

def generate_triples_known_limits(max_leg, max_hypotenuse, max_perimeter)
  solutions = Set.new
  (1..Math.sqrt(max_perimeter / 2).to_i).each do |m|
    (1...m).each do |n|
      a, b, c, perim = euclids_formula(m, n)
      break if perim > max_perimeter
      next unless in_bounds?(a, b, c, perim, max_leg, max_hypotenuse, max_perimeter) && !solutions.include?([a, b, c])

      solutions.merge scaled_triples(a, b, c, scale_limit(b, c, perim, max_leg, max_hypotenuse, max_perimeter))
    end
  end
  solutions
end
