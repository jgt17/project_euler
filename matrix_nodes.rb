# frozen_string_literal: true

MATRIX = File.read('p081_matrix.txt').split("\n").map { |row| row.split(',').map(&:to_i) }

# implementation of node for dijkstras for problem 81
class MatrixNode < Node
  def initialize(parent, value, element)
    super(parent, value + MATRIX[element[0]][element[1]], element)
  end

  def goal?
    @element[0] == MATRIX.size - 1 && @element[1] == MATRIX[0].size - 1
  end

  def children
    children = []
    children.append(right_child) unless @element[0] + 1 >= MATRIX.size
    children.append(down_child) unless @element[1] + 1 >= MATRIX[0].size
    children
  end

  protected

  def right_child
    self.class.new(self, @value, [@element[0] + 1, @element[1]])
  end

  def down_child
    self.class.new(self, @value, [@element[0], @element[1] + 1])
  end
end


# node that con move in up, down, and right (problem 82)
class MatrixNode3 < MatrixNode
  def goal?
    @element[1] == MATRIX[0].size - 1
  end

  def children
    (@element[0]).positive? ? super.append(up_child) : super
  end

  protected

  def up_child
    self.class.new(self, @value, [@element[0] - 1, @element[1]])
  end
end

# node that can move up, down, left, and right (problem 83)
class MatrixNode4 < MatrixNode3
  def goal?
    @element[0] == MATRIX.size - 1 && @element[1] == MATRIX[0].size - 1
  end

  def children
    (@element[1]).positive? ? super.append(left_child) : super
  end

  protected

  def left_child
    self.class.new(self, @value, [@element[0], @element[1] - 1])
  end
end
