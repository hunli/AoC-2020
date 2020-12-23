class Node
  attr_accessor :next, :prev, :value

  def initialize(value)
    @value = value
  end
end

class LinkedList
  attr_accessor :head, :tail, :hash

  def initialize
    @hash = {}
  end

  def add(value)
    if @head
      node = Node.new(value)
      node.prev = @tail
      @tail.next = node
      @tail = node
      @hash[value] = node
    else
      @head = Node.new(value)
      @tail = @head
      @hash[value] = @head
    end
  end
end

def next_three(node)
  next_node = node.next

  head_of_three = next_node
  next_node = next_node.next
  next_node = next_node.next

  node.next = next_node.next
  next_node.next.prev = node
  next_node.next = nil
  head_of_three.prev = nil

  [node, head_of_three]
end

def include?(node, value)
  until node == nil
    return true if node.value == value
    node = node.next
  end

  false
end

def get_destination_cup(current_node, next_three, max_size)
  desired = current_node.value - 1

  while include?(next_three, desired) || desired == 0
    desired -= 1

    if desired <= 0
      desired = max_size
    end
  end

  desired
end

def work(node, hash, max_size, move_target = 100)
  current_index = 0
  move = 1

  while move <= move_target
    # p move
    node, head_of_three = next_three(node)

    destination_cup = get_destination_cup(node, head_of_three, max_size)

    destination_node = hash[destination_cup]
    tail_of_three = head_of_three.next.next

    tail_of_three.next = destination_node.next
    destination_node.prev = tail_of_three
    destination_node.next = head_of_three
    head_of_three.prev = destination_node

    node = node.next
    move += 1
  end

  node
end

def get_clockwise_labels(node)
  next_node = node.next
  values = []

  until next_node == node
    values << next_node.value
    next_node = next_node.next
  end

  values.map(&:to_s).join
end

def convert_to_nodes(input)
  list = LinkedList.new
  input.to_s.split("") { |value| list.add(value.to_i) }
  list
end

def part1(input)
  list = convert_to_nodes(input)

  node = list.head
  node.prev = list.tail
  list.tail.next = node

  hash = list.hash
  work(node, hash, input.to_s.length)
  get_clockwise_labels(hash[1])
end

def part2(input)
  list = convert_to_nodes(input)
  iteration_num = 1_000_000
  (10..iteration_num).each {|x| list.add(x) }

  node = list.head
  node.prev = list.tail
  list.tail.next = node

  hash = list.hash
  work(node, hash, iteration_num, iteration_num * 10)

  hash[1].next.value * hash[1].next.next.value
end

input = 315679824
dummy_input = 389125467

p "Part 1: #{part1(input)}"
p "Part 2: #{part2(input)}"
