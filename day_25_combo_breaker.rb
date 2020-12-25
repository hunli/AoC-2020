def get_loop_size(target)
  value = 1
  count = 0
  subject_number = 7

  until value == target
    value *= subject_number
    value = value % 20201227
    count += 1
  end

  count
end

def transform_subject(subject_number, loop_size)
  value = 1

  loop_size.times do
    value *= subject_number
    value = value % 20201227
  end

  value
end

def part1(input)
  card_public_key, door_public_key = input.split.map(&:to_i)
  card_loop_size = get_loop_size(card_public_key)
  door_loop_size = get_loop_size(door_public_key)

  door_encryption_key = transform_subject(card_public_key, door_loop_size)
  card_encryption_key = transform_subject(door_public_key, card_loop_size)
  raise unless door_encryption_key == card_encryption_key

  door_encryption_key
end

input = "14222596
4057428"

dummy_input = "5764801
17807724"

p "Part 1: #{part1(input)}"
