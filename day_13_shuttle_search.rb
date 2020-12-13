def get_closest_timestamp(input, earliest_time)
  timestamp_hash = {}

  input.each do |bus_id|
    timestamp_hash[bus_id] = (earliest_time / bus_id + 1) * bus_id
  end

  timestamp_hash
end

def part1(input, earliest_time)
  bus_ids = input.select {|x| x.to_i > 0 }.map(&:to_i)
  timestamp_hash = get_closest_timestamp(bus_ids, earliest_time)
  earlist_arrival_time = timestamp_hash.values.min
  (earlist_arrival_time - earliest_time) * timestamp_hash.key(earlist_arrival_time)
end

def valid?(input, timestamp, base_index)
  last_value = timestamp
  multiplicator = input[base_index].to_i
  success = true

  input.each_with_index do |bus_id, index|
    if bus_id == 'x'
      last_value += 1
      true
    elsif last_value % bus_id.to_i == 0
      last_value += 1
      multiplicator *= bus_id.to_i unless index == base_index
      true
    else
      success = false
      break
    end
  end

  [success, multiplicator]
end

def part2(input)
  base = input.select{|x| x != 'x' }.max.to_i
  index = input.index(base.to_s)
  timestamp = base.to_i
  new_multiplicator = base

  while true
    success, new_multiplicator = valid?(input, timestamp - index, index)
    break if success

    base = new_multiplicator if new_multiplicator > base
    timestamp += base
  end

  timestamp - index
end

input = %w[
  17 x x x x x x x x x x 37 x x x x x 907 x x x x x x x x x x x 19 x x x x x x x x x x 23 x x x x x 29 x 653 x x x x x x x x x 41 x x 13
]

dummy_input = %w[7 13 x x 59 x 31 19]

earliest_time = 1000186

p "Part 1: #{part1(input, earliest_time)}"
p "Part 2: #{part2(input)}"

# p part2(%w[17 x 13 19]) == 3417
# p part2(%w[67 7 59 61]) == 754018
# p part2(%w[67 x 7 59 61]) == 779210
# p part2(%w[1789 37 47 1889]) == 1202161486
