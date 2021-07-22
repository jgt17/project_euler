# frozen_string_literal: true

require 'set'
require_relative 'priority_queue'

# a node for dijkstra's algorithm
class Node
  include Comparable

  attr_reader :parent
  attr_reader :value
  attr_reader :element

  def initialize(parent, value, element)
    super()
    @parent = parent
    @value = value
    @element = element
  end

  def <=>(other)
    return nil unless other.is_a? Node

    @value <=> other.value
  end

  def ==(other)
    return false unless other.is_a? Node

    @element == other.element
  end

  def to_s
    "#{@value}: #{@element}"
  end

  def trace_path
    "#{@parent&.trace_path} => #{@element}"
  end

  def hash
    @element.hash
  end

  def eql?(other)
    hash == other.hash
  end

  # below methods to be implemented by a subclass according to the parameters of the problem at hand
  def children; end

  def goal?; end
end

def dijkstras(start)
  queue = PriorityQueue.new(start)
  finalized = Set.new

  until queue.peek.goal?
    next_node = queue.pop
    next unless finalized.add? next_node

    children = next_node.children
    children&.each { |child| queue.push child }
  end

  queue.peek
end
