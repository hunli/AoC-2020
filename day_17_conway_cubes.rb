input = [
"##...#.#
#..##..#
..#.####
.#..#...
########
######.#
.####..#
.###.#.."
]

dummy_input = [
".#.
..#
###"
]

ACTIVE = '#'
INACTIVE = nil

def convert_to_hash(input)
  hash = {}

  input.first.split("\n").each_with_index do |row, row_index|
    row_hash = {}

    row.split("").each_with_index do |value, col_index|
      row_hash[col_index] = value if value == ACTIVE
    end

    hash[row_index] = row_hash unless row_hash.empty?
  end

  {0 => {0 => hash}}
end

def count_all_active(puzzle)
  count = 0

  puzzle.each do |w_index, cube|
    cube.each do |z_index, square|
      square.each do |x_index, row|
        row.each do |y_index, value|
          count += 1 if value == ACTIVE
        end
      end
    end
  end

  count
end

def count_surrounding(puzzle, w, z, x, y)
  count = 0

  (w-1 .. w + 1).each do |w_index|
    (z-1 .. z + 1).each do |z_index|
      (x - 1.. x + 1).each do |x_index|
        (y - 1..y + 1).each do |y_index|
          count += 1 if get_value(puzzle, w_index, x_index, y_index, z_index) == ACTIVE && !(w_index == w && x_index == x && y_index == y && z_index == z)
        end
      end
    end
  end

  count
end

def get_value(hash, w, x, y, z)
  hash.dig(w, z,x,y) == ACTIVE ? ACTIVE : INACTIVE
end

def run_round(puzzle, allow_4d)
  w_indexes = puzzle.keys
  z_indexes = puzzle.values.map(&:keys).flatten
  x_indexes = puzzle.values.map {|x| x.values.map(&:keys)}.flatten.uniq
  y_indexes = puzzle.values.map {|x| x.values.map {|y| y.values.map(&:keys) } }.flatten.uniq

  new_hash = {}

  w_range = if allow_4d
    (w_indexes.min - 1)..(w_indexes.max + 1)
  else
    0..0
  end

  (w_range).each do |w|
    ((z_indexes.min - 1)..(z_indexes.max + 1)).each do |z|
      ((x_indexes.min - 1)..(x_indexes.max + 1)).each do |x|
        ((y_indexes.min - 1)..(y_indexes.max + 1)).each do |y|
          count = count_surrounding(puzzle, w, z, x, y)

          if get_value(puzzle, w, x, y, z) == ACTIVE && (count == 2 || count == 3)
            new_hash[w] ||= {}
            new_hash[w][z] ||= {}
            new_hash[w][z][x] ||= {}
            new_hash[w][z][x][y] ||= ACTIVE
          elsif get_value(puzzle, w, x, y, z) == INACTIVE && count == 3
            new_hash[w] ||= {}
            new_hash[w][z] ||= {}
            new_hash[w][z][x] ||= {}
            new_hash[w][z][x][y] ||= ACTIVE
          end
        end
      end
    end
  end

  new_hash
end

def solve(input, allow_4d = false)
  puzzle = convert_to_hash(input)

  6.times do
    puzzle = run_round(puzzle, allow_4d)
  end

  count_all_active(puzzle)
end

def part1(input)
  solve(input)
end

def part2(input)
  solve(input, true)
end

p "Part 1: #{part1(input)}"
p "Part 2: #{part2(input)}"
