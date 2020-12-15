def convert_to_game_data(input)
  hash = {}
  input.each_with_index { |value, index| hash[value] = index + 1 }
  hash
end

def part1(input, desired_turn = 2020)
  hash = convert_to_game_data(input)
  current_turn = hash.length + 1
  last_spoken = input.last
  last_turn_seen = current_turn

  (current_turn..desired_turn).each do |turn|
    if last_turn_seen.nil?
      last_turn_seen = hash[0]
      hash[0] = turn
      last_spoken = 0
      current_turn = turn
    else
      turn_difference = current_turn - last_turn_seen
      last_turn_seen = hash[turn_difference]
      hash[turn_difference] = turn
      last_spoken = turn_difference
      current_turn = turn
    end
  end

  last_spoken
end

def part2(input)
  part1(input, 30000000)
end

input = [16,11,15,0,1,7]
dummy_input = [0,3,6]

p "Part 1: #{part1(input)}"
p "Part 2: #{part2(input)}"

# p part2([0,3,6]) == 175594
# p part2([1,3,2]) == 2578
# p part2([2,1,3]) == 3544142
# p part2([2,3,1]) == 6895259
# p part2([1,2,3]) == 261214
# p part2([3,2,1]) == 18
# p part2([3,1,2]) == 362
