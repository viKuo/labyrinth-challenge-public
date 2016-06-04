def calculate(array)
  stack = Stack.new
  array.each do |item|
    if (0..9).include?(item)
      stack.push(item)
    else
      value_1 = stack.pop
      value_2 = stack.pop
      case item
      when "+"
        result = value_1 + value_2
      when "-"
        result = value_2 - value_1
      when "x"
        result = value_1 * value_2
      end
      stack.push(result)
    end
  end
  stack.pop
end


class Stack
  attr_accessor :length
  def initialize
    @stack = LinkedList.new
    @length = 0
  end

  def push(element)
    @stack.insert_first(element)
    @length += 1
  end

  def pop
    if !empty?
      return_value = @stack.remove_first
      @length -= 1
      return_value.element
    end
  end

  def empty?
    @length == 0 ? true : false ;
  end

  def top
    @stack.element
  end
end

class Node
  attr_accessor :element, :next_node
  def initialize(element)
    @element = element
    @next_node = nil
  end

  def insert_after(other_node)
    @next_node = other_node
  end

  def remove_after()
    @next_node = nil
  end
end

class LinkedList
  def initialize
    @linked_list = nil
  end

  def insert_first(element)
    if (@linked_list == nil)
      @linked_list = Node.new(element)
    else
      new_node = Node.new(element)
      new_node.insert_after(@linked_list)
      @linked_list = new_node
    end
  end

  def remove_first
    if (@linked_list != nil)
      removed_node = @linked_list
      @linked_list = @linked_list.next_node
      removed_node
    else
      @linked_list = nil
    end
  end

  def insert_last(element)
    if @linked_list == nil
      @linked_list = Node.new(element)
      @current_node = @linked_list
    else
      cursor = @linked_list
      (size-1).times { cursor = cursor.next_node }
      cursor.next_node = Node.new(element)
    end
  end

  def remove_last
    if (@linked_list.next_node != nil)
      cursor = @linked_list
      (size-2).times { cursor = cursor.next_node }
      cursor.next_node = nil
    else
      @linked_list = nil
    end
  end

  def element
    @linked_list.element
  end

  def size
    return 0 if @linked_list == nil
    i = 1
    cursor = @linked_list
    while cursor.next_node != nil
      next_node
      i += 1
    end
    i
  end

  def all
    array = []
    cursor = @linked_list
    size.times do
      array << cursor.element
      cursor = cursor.next_node
    end
    array
  end
end
