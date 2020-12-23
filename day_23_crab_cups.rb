def work(array, move_target = 100)
  current_index = 0
  move = 1

  while move <= move_target
    current_cup = array[current_index]
    next_three = []

    3.times do |x|
      next_three << array[(current_index + x + 1) % array.length]
    end

    array.delete_if {|x| next_three.include?(x)}
    destination_cup = current_cup - 1

    index = (current_index + 1) % array.length

    until array[index % array.length] == destination_cup
      if destination_cup == 0
        destination_cup = array.max
      elsif next_three.include?(destination_cup)
        destination_cup -= 1
      end

      index += 1
    end

    index = index % array.length
    array.insert(index + 1, *next_three)

    array =  array[current_index + 1..-1] + array[0..current_index]
    current_index = 0
    move += 1
  end

  array
end

def get_clockwise_labels(array)
  start_index = array.index(1)
  (array[start_index + 1..-1] + array[0...start_index]).map(&:to_s).join
end

def part1(input)
  array = input.to_s.split("").map(&:to_i)
  array = work(array)
  get_clockwise_labels(array)
end

def part2(input)
  array = input.to_s.split("").map(&:to_i)
  iteration_num = 1_000_000
  (10..iteration_num).each {|x| array << x}

  array = work(array, iteration_num * 10)
  start_index = array.index(1)
  [array[start_index + 1], array[start_index + 2]]
end

input = 315679824
dummy_input = 389125467

p part1(input)
p part2(input)
