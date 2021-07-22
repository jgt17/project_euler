# frozen_string_literal: true

# num unique solutions for a given pythagorean triple (a,b,c), a < b is b / 2
# reduced to a / 2 when x, y, z < M and x = a, b = y + z

# num solutions for exactly M = sum of a / 2 over all pythagorean triples with a == M

require_relative 'util/right_triangles'

def num_legal_cubes_from_triple(triple, max_edge_length)
  [(triple[1] / 2) - (triple[1] - triple[0] - 1), 0].max + (triple[1] <= max_edge_length ? ((triple[0]) / 2 ) : 0)
end

target = 1_000_000
triples = generate_triples(max_leg: target / 20)
# M is probably less than target / 20, and I don't feel like optimizing further at this point
p((1..).find { |m| triples.select { |triple| triple[0] <= m && triple[1] <= 2 * m }.reduce(0) { |memo, triple| memo + num_legal_cubes_from_triple(triple, m)} > target })
# yes, this is horribly inefficient, but it's built on my original approach and insight. generate_tuples is
# reasonably efficient for bulk operations, but a bit clunky for checking m, then m + 1, etc
# selecting from a pre-generated set helps with that but introduces it's own issues
#
# a much better solution in c# from https://www.mathblog.dk/project-euler-86-shortest-path-cuboid/
# int l = 2;
# int count = 0;
# int target = 1000000;
#
# while (count < target) {
#     l++;
#     for (int wh = 3; wh <= 2 * l; wh++) {
#         double sqrt = Math.Sqrt(wh * wh + l * l);
#         if (sqrt == (int)(sqrt)) {
#             count += (wh <= l) ? wh / 2 : 1 + (l - (wh+1)/2);
#         }
#     }
# }
