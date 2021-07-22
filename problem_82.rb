# frozen_string_literal: true

require_relative 'util/dijkstras'
require_relative 'matrix_nodes'

left_column = (0...MATRIX.size).map { |i| MatrixNode3.new(nil, 0, [i, 0]) }
p dijkstras(left_column).value
