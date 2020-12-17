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
INACTIVE = '.'

def count_active_edges(arr)
  count = 0

  arr.each do |square|
    rows = square.split("\n")
    rows.each_with_index do |row, index|
      cols = row.split('')

      if index == 0 || index == row.length - 1
        cols.each {|value| count += 1 if value == ACTIVE}
      else
        count += 1 if cols[0] == ACTIVE
        count += 1 if cols[-1] == ACTIVE
      end
    end
  end

  count
end

def count_active_frame(square)
  count_all_active([square])
end

def count_neighbors(square, x, y, ignore_exact = false)
  rows = square.split("\n")
  start_x = [0, x - 1].max
  end_x = [rows.length - 1, x + 1].min

  start_y = [0, y - 1].max
  end_y = [rows[0].length - 1, y + 1].min

  count = 0

  (start_x..end_x).each do |x_index|
    (start_y..end_y).each do |y_index|
      count += 1 if rows[x_index][y_index] == ACTIVE && !(x_index == x && y_index == y && ignore_exact)
    end
  end

  count
end

def populate_arr(original_arr, new_arr)
  original_arr.each_with_index do |square, z_index|
    rows = square.split("\n")
    new_square = []

    (0..rows.length - 1).each do |x_index|
      new_row = []

      (0..rows[0].length - 1).each do |y_index|
        count = 0
        if z_index > 0
          count += count_neighbors(original_arr[z_index - 1], x_index, y_index)
        end

        count += count_neighbors(original_arr[z_index], x_index, y_index, true)

        if z_index < original_arr.length - 1
          count += count_neighbors(original_arr[z_index + 1], x_index, y_index)
        end

        if rows[x_index][y_index] == ACTIVE && (count == 2 || count == 3)
          new_row << ACTIVE
        elsif rows[x_index][y_index] == INACTIVE && count == 3
          new_row << ACTIVE
        else
          new_row << INACTIVE
        end
      end

      new_square << new_row.join
    end

    new_arr[z_index] = new_square.join("\n")
  end

  new_arr
end

def run_cycle(arr)
  if count_active_edges(arr) > 2
    arr = arr.map {|square| expand_grid_by_xy(square) }
  end

  if count_active_frame(arr[0]) > 2
    arr = expand_grid_by_z(arr)
  end
  populate_arr(arr, arr.clone)
end

def count_all_active(arr)
  count = 0

  arr.each do |square|
    square.split.each do |row|
      row.split('').each do |value|
        count += 1 if value == ACTIVE
      end
    end
  end

  count
end

def expand_grid_by_z(arr)
  square = arr[0]
  rows = square.split
  row_len = rows.length
  col_len = rows[0].length

  new_frame = []
  row_len.times { new_frame << '.' * col_len }
  new_string = new_frame.join("\n")
  [new_string] + arr + [new_string]
end

# Takes square as a string and expands it
def expand_grid_by_xy(square)
  rows = square.split
  [
    '.' * (rows.length + 2),
    rows.map {|x| ".#{x}." },
    '.' * (rows.length + 2)
  ].compact.join("\n")
end

def part1(input)
  arr = input

  6.times do
    arr = run_cycle(arr)
  end

  count_all_active(arr)
end

pp part1(input)
