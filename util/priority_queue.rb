# frozen_string_literal: true

# a basic, binary-min-heap-based priority queue
class PriorityQueue
  def initialize(*initial_values)
    super()
    @heap = []
    initial_values.each { |val| val.respond_to?(:each) ? val.each { |el| push(el) } : push(val) }
  end

  def peek
    @heap[0]
  end

  def pop
    return @heap.pop if @heap.length == 1

    temp = @heap[0]
    @heap[0] = @heap.pop
    sift_down(0)
    temp
  end

  def push(new_el)
    already_exists_at = nil # @heap.find_index { |item| item.eql?(new_el) }
    if already_exists_at && @heap[already_exists_at] > new_el
      @heap[already_exists_at] = new_el
      sift_up(already_exists_at)
    else
      @heap.push(new_el)
      sift_up(@heap.length - 1)
    end
  end

  def pop_push(new_el)
    temp = @heap[0]
    @heap[0] = new_el
    sift_down(0)
    temp
  end

  def to_s
    (@heap.map { |el| el.to_s + ',' }).to_s
  end

  private

  def parent(index)
    index.zero? ? nil : (index - 1) / 2
  end

  def left_child(index)
    left = (2 * index) + 1
    @heap.size > left ? left : nil
  end

  def right_child(index)
    right = (2 * index) + 2
    @heap.size > right ? right : nil
  end

  def min_child(index)
    left = left_child(index)
    return nil unless left

    right = right_child(index)
    return left unless right

    @heap[left] <= @heap[right] ? left : right
  end

  def sift_down(index)
    child = min_child(index)
    return unless child && @heap[child] < @heap[index]

    swap(index, child)
    sift_down(child)
  end

  def sift_up(index)
    par = parent(index)
    return unless par && @heap[par] > @heap[index]

    swap(par, index)
    sift_up(par)
  end

  def swap(index1, index2)
    temp = @heap[index1]
    @heap[index1] = @heap[index2]
    @heap[index2] = temp
  end
end
