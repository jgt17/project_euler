# frozen_string_literal: true

require 'set'

# a node for dijkstra's algorithm
class Node
  TRIANGLE = p(File.read('p067_triangle.txt').split("\n").map { |row| row.split.map { |n| 100 - n.to_i } })

  attr_reader :row
  attr_reader :col
  attr_reader :total_cost
  attr_reader :parent

  def initialize(row, col, parent, total, is_end_node = false)
    @row = row
    @col = col
    @parent = parent
    # cost is wasted potential of the node, ie, 100 - value
    @total_cost = total + (is_end_node ? 0 : value)
    @end_node = is_end_node
    super()
  end

  def value
    @row < TRIANGLE.size ? TRIANGLE[@row][@col] : 0
  end

  def children
    return [Node.new(@row + 1, 0, self, @total_cost, true)] if @row == TRIANGLE.size - 1

    [Node.new(@row + 1, @col, self, @total_cost), Node.new(@row + 1, @col + 1, self, @total_cost)]
  end

  def end_node?
    @end_node
  end

  def to_s
    "Row: #{@row}, Col: #{@col}, Value: #{value}, Total Cost: #{@total_cost}"
  end

  def to_sym
    "#{@row}_#{@col}".to_sym
  end

  def self.triangle_size
    TRIANGLE.size
  end
end
# cost to each node is monotonically increasing, so can use a radix-based priority queue
class RadixQueue
  def initialize(num_values)
    @queue = Array.new(num_values) { [] }
    @index = 0
    @minimum_costs_found = Hash.new(10_000_000_000_000) # larger than any possible cost for this problem
    super()
  end

  # could also delete the extant node for the same position with higher cost, but not worth it
  def push(node)
    return unless node.total_cost < @minimum_costs_found[node.to_sym]

    @queue[node.total_cost].push(node)
    @minimum_costs_found[node.to_sym] = node.total_cost
  end

  def pop
    @index += 1 while @queue[@index].empty?
    @queue[@index].pop
  end
end

def dijkstras
  queue = RadixQueue.new(Node.triangle_size * 99)
  queue.push Node.new(0, 0, nil, 0)

  next_node = queue.pop
  until next_node.end_node?
    next_node.children.each { |child| queue.push(child) }
    next_node = queue.pop
    puts next_node
  end
  next_node
end

p((100 * Node.triangle_size) - dijkstras.total_cost) # convert back to total from total cost
