class Queue
	attr_accessor :length
	def initialize
		@queue = LinkedList.new
		@length = 0
	end

	def enqueue(element)
		@queue.insert_last(element)
		@length += 1
	end

	def dequeue
		if !empty?
			@length -= 1
			value = @queue.remove_first
			value.element
		end
	end

	def peel
		@queue.element
	end

	def empty?
		@length == 0 ? true : false
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
      removed_node.next_node = nil
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
      (length-1).times { cursor = cursor.next_node }
      cursor.next_node = Node.new(element)
    end
  end

  def remove_last
    if (@linked_list.next_node != nil)
      cursor = @linked_list
      (length-2).times { cursor = cursor.next_node }
      return_node = cursor.next_node
      cursor.next_node = nil
      return_node
    else
      @linked_list = nil
    end
  end

  def element
    @linked_list.element
  end

  def length
    return 0 if @linked_list == nil
    i = 1
    cursor = @linked_list
    while cursor.next_node != nil
      cursor = cursor.next_node
      i += 1
    end
    i
  end

  def all
    array = []
    cursor = @linked_list
    length.times do
      array << cursor.element
      cursor = cursor.next_node
    end
    array
  end
end

# linked = LinkedList.new
# linked.insert_last(1)
# linked.insert_last(2)
# linked.insert_last(3)
# linked.insert_last(4)
# linked.insert_last(5)

# removed_node = linked.remove_first

# p removed_node.element