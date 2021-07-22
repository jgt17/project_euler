# frozen_string_literal: true

require_relative 'util/dijkstras'
require_relative 'matrix_nodes'

p dijkstras(MatrixNode4.new(nil, 0, [0, 0])).value
