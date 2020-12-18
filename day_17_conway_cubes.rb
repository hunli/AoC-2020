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

  {0 => hash}
end

def count_all_active(puzzle)
  count = 0

  puzzle.each do |z_index, square|
    square.each do |x_index, row|
      row.each do |y_index, value|
        count += 1 if value == ACTIVE
      end
    end
  end

  count
end

def count_surrounding(puzzle, z, x, y)
  count = 0

  (z-1 .. z + 1).each do |z_index|
    (x - 1.. x + 1).each do |x_index|
      (y - 1..y + 1).each do |y_index|
        count += 1 if get_value(puzzle, x_index, y_index, z_index) == ACTIVE && !(x_index == x && y_index == y && z_index == z)
      end
    end
  end

  count
end

def get_value(hash, x, y, z)
  hash.dig(z,x,y) == ACTIVE ? ACTIVE : INACTIVE
end

def run_round(puzzle)
  z_indexes = puzzle.keys
  x_indexes = puzzle.values.map(&:keys).flatten
  y_indexes = puzzle.values.map {|x| x.values.map(&:keys)}.flatten.uniq
  new_hash = {}

  ((z_indexes.min - 1)..(z_indexes.max + 1)).each do |z|
    ((x_indexes.min - 1)..(x_indexes.max + 1)).each do |x|
      ((y_indexes.min - 1)..(y_indexes.max + 1)).each do |y|
        count = count_surrounding(puzzle, z, x, y)

        if get_value(puzzle, x, y, z) == ACTIVE && (count == 2 || count == 3)
          new_hash[z] ||= {}
          new_hash[z][x] ||= {}
          new_hash[z][x][y] ||= ACTIVE
        elsif get_value(puzzle, x, y, z) == INACTIVE && count == 3
          new_hash[z] ||= {}
          new_hash[z][x] ||= {}
          new_hash[z][x][y] ||= ACTIVE
        end
      end
    end
  end

  new_hash
end

def part1(input)
  puzzle = convert_to_hash(input)
  6.times do
    puzzle = run_round(puzzle)
  end
  count_all_active(puzzle)
end

p part1(input)
