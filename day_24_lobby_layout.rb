class Tile
  attr_accessor :color

  def initialize
    @vertical = 0
    @horizontal = 0
    @color = :black
  end

  def toggle_color
    if @color == :white
      @color = :black
    else
      @color = :white
    end
  end
end

def get_coords(line)
  vertical = 0
  horizontal = 0
  index = 0

  while index < line.length
    char = line[index]

    case char
    when 'n'
      vertical += 1
      index += 1
      horizontal += line[index] == 'e' ? 0.5 : -0.5
    when 'e'
      horizontal += 1
    when 'w'
      horizontal -= 1
    when 's'
      vertical -= 1
      index += 1
      horizontal += line[index] == 'e' ? 0.5 : -0.5
    else
      raise "Unkonwn orientation: #{x}"
    end

    index += 1
  end

  "#{horizontal.to_f},#{vertical.to_f}"
end

def get_tile_hash(input)
  hash = {}
  input.each_with_index do |pattern, index|
    coord = get_coords(pattern)

    if hash[coord].nil?
      hash[coord] = Tile.new
    else
      hash[coord].toggle_color
    end
  end

  hash
end

def get_adjacent_tile(coordinate)
  adjacent_list = []
  x, y = coordinate.split(",").map(&:to_f)

  adjacent_list << "#{x + 1},#{y}"
  adjacent_list << "#{x - 1},#{y}"
  adjacent_list << "#{x + 0.5},#{y + 1}"
  adjacent_list << "#{x - 0.5},#{y + 1}"
  adjacent_list << "#{x + 0.5},#{y - 1}"
  adjacent_list << "#{x - 0.5},#{y - 1}"

  adjacent_list
end

def get_adjacent_tiles(hash)
  adjacent_list = []

  hash.keys.each do |coord|
    adjacent_list += get_adjacent_tile(coord)
    adjacent_list << coord
  end

  adjacent_list
end

def count_black(hash)
  sum = 0
  hash.values.each {|t| sum += 1 if t.color == :black }
  sum
end

def part1(input)
  hash = get_tile_hash(input)
  count_black(hash)
end

def part2(input, days = 10)
  hash = get_tile_hash(input)
  current_day = 0

  while current_day < days
    new_hash = {}
    adjacent_tile_list = get_adjacent_tiles(hash)
    adjacent_tile_list.each do |coord|
      adjacent = get_adjacent_tile(coord)
      sum = adjacent.sum {|x| hash[x] && hash[x].color == :black ? 1 : 0 }

      if hash[coord] && hash[coord].color == :black
        if sum != 0 && sum <= 2
          new_hash[coord] = Tile.new
        end
      else
        if sum == 2
          new_hash[coord] = Tile.new
        end
      end
    end

    hash = new_hash
    current_day += 1
  end

  count_black(hash)
end

input = %w[
  wnwwswnewewnwwnesewseewnesewnwsenw
  sesesewseseseenesesesesenwseseseseseewne
  neeswwneswnwenwswesewsenewnewese
  nwnwnenwnwswswnenenwnwneneenenesenene
  wweenwnwnwsesewnwsewwsenwwnesw
  nenwnwnwneneswnenenenwnenwnenwene
  eseenewseeseewesesweeseesenesee
  newswswswneenewneneesenwneneneneene
  neseseseswswswseswseswneswseswswswwswse
  nenewnwnwnwnwenesenwnwnwwnwnenenwnenw
  eesweeseeeeeenwnwnweeesewe
  esweenesenweeeseeeweseseesese
  swnenenenenenenenenenenenenene
  swwwwswwswswswswnwswwswweswww
  swnwswwneenwswsesweswsenwsweseneswsw
  nwnenewnwnwnwnewswnenesenwnwnenesenwnwne
  swneswswneswseswwswswswnesenwwswswswswse
  sesewsesesesesesenwseswseeseseeseneese
  nwsenenwseswnwnwswswseswwnenesewse
  seneneswswesweswswwwsenwseswswswswwsw
  nenwewneneneneseneneeneswneneenenenenene
  seneneneeneneswenewseswneenewne
  nwnwnwsenwnwnwnwnwnwnwnwnwnwnwwnenwenw
  nwnwwnwnwnwnwwnwnwnwwwwwsenw
  neneneswneswnwneneeneneneneneneswnenenwnw
  nwnwnwnwwswweewnwwewnwwnw
  wneneneseweswnenwneneeneswnenwnenwnee
  ewnewwwsewwwenewnwwsewswwnwsw
  nwnenenwnenenenenenewenenenenene
  senweswswwseseswwswnwwswnwnwwswesww
  wwwwseswnwwwwwwwnwwnewnwww
  wwswnweswsewewsw
  neswsewseseneswswseseswwsweswswsesewsw
  nwnwseewswsewseewwnwsesewnwnenwnw
  nweeeneeneenenwsweeneeesweneene
  swsenwseswseswnwseseseswseneseseseswsesesw
  nwwnwnwnwnwswnwnwnwnwnwnwwnwnwenwnw
  wwewwsewwwwwwwwnwewwww
  nenesenwneseeneswswnweswenewnenwswnene
  seseeseseswnewsesenesewneeseseseeswse
  swnwswswsesweeswswnwwneneseswsw
  swseswneswswseseswseswswswswswswswnenwsww
  wwnwnwwswnwwwnwnwnenwnwnenwsewnwnwnw
  nwneeswwnenenwnwwnwnewsenwnenenwnenese
  sewswneswswsweswswnesweswsenwsesesesw
  nwnwneneseswnwnweseswnwswnwswenwnwnenwe
  enesenwswswnweeneneeeswnenenwese
  wnwseneewneweseenenwsewesene
  swwsenewnwnwwwswsewsweweenwwnw
  wswsewswwwnwwnwnwewnwenwnwnewnw
  wwwwewnesenewwswwwnwnwnwseweswse
  nweneneeeneeweeeseewswseeseswe
  wswneswswwswswswwwsw
  swneswseswseswewneswswswewswswswswwe
  eesewwwsewnwwnwneweswsene
  neneneswneneneenenenwenenenenewneene
  swswneenwwesenweeneneneseneneenenenw
  nwnenenenwsenwnenwnenenenenenenenenenwsw
  nwswwnwsenwwnewnwnwswwwesenenenwww
  swnwseseswnwswsesenwswseseseseswsweseswsw
  neneseeneseweswwneswenenwewneeene
  eeeeeenwnweweneeeseeeeeswsesw
  wswsewnwnenwneenewsewswnew
  nwenwwwwwseswswesewswnewe
  swswswswswnweswsweswswswswswswnwewswwsw
  wneneenewsweneeeweeenenweesee
  swneeswsenenwsenwnwseswwnenwnwswwenw
  eweneeeeneeswnweeseeeeenee
  seseseneseeneseswwnwseseseswswseneeese
  seswenenenweneene
  wnwwwwwwsewwwewwwnewwww
  wewwswwwewwwwnwwwwwwwww
  eneeeeneswseeenweeeneeeweene
  wwwwwnewwswwwswwswnewwwsww
  newseewseesesewseswswswseseswesese
  eesenwnenenwwsenewsenwnenewnwnenwnwsw
  nwnwneswnwnwenwswsenwnwnwnwnwwewenwse
  nesenweeenwwswwwwnwww
  eeneneenenwseswsweeswwnwsenwneene
  sweeeeeeeneeeneneenenee
  wwswwwswwnwwswwnewsewwwwwnew
  ewsweswnwwwwswwwwwnew
  swnwnwewnwneeswnwesw
  nwswnwsenwnwenwnwnwnwnwnwnwnwnwwnwnwnenwnw
  wwwnwewnewswwwnwwewwwwnwswse
  wwneswswnwswenwswnwnwwnwwenweswee
  ewseesesweeeeeeseeeeeeenwe
  swwnewswneswsewswswswwswswswwswswsww
  seneesewseseseswswswnwwseeswenwsese
  enweeseeeeee
  nwswnewnwswnwnesenwenwnenwnwswnenenene
  nwneswneneeenenenenenesewseswnenenesw
  wswswsweswewswwswswswswnwnesewswsw
  swswswswswneswswswseswnwswswswswswswswsw
  enenenwnenenwnesenenenwswnwsw
  swswswswswswswswwswwnewswsw
  wneesewseseseneneneswswnwneesewnwwsew
  senesesenesenwseseswseseseseswseseseswnw
  senwenwwwwnwnwww
  nenenwnwnwnenewneswnwesenenwneneswne
  swwswswswsenwsweswswswnwsewswswswswenw
  swwswewswswswswnw
  wsewsewseneenewwswseneseswneseswsewe
  wswswswwnwseswswswswswswswswswswsw
  nenwnwnenenwnwnwenenwnwnwnesenenenenwswne
  swseswwswwnewwswnwswww
  swsenwsewswwnwswnwswswneswwswsewsesw
  swseeseswswnwswsenwseswswwswe
  enesesesesesesewseswneseseswsenwse
  swsesesweeneesesenwneswnwswseseseseeswne
  swwnenwnwneenwnenweneswwnwwnwnee
  seseenenwsenwnweseswswswswseswswsenesesw
  newwwnwnwnwwnwnwwwwwsenwenwnwwe
  eeeseesweeseeneseeeese
  nwseseesewseseseneesenwseeseweeenw
  ewweswnwnewwwwwwswswseswwswseswsw
  wneneswseesenwneswnwswsenenenenwnewnw
  wseweneneswswweswswswww
  eeeeewswnweeeeeneeeeeee
  swnwwseeeneewswseesesenweneswnese
  swwsweseneneseswnweneweseenwseswnee
  nwwnwnenwwwnwsew
  nenwnwswwnwnwwsenwnwsenwnwnwnenwnwnwnwsee
  nwewwsewwnwswnwsewneswwnenwwwse
  nwwewnwnwwwswnwwwwnwwwnw
  nwnwnwnwnwnwwnwnwnwwneswnwsenwwwnwnw
  swswweseseswswsenwese
  wswwswnwewneswsweeewswwswnenwsw
  wswwswswswwwwnewsewwwewswwww
  eeswsenwnwneweneweneeeweseewe
  neseseseneseswsenwwsewewseseswswsenene
  newwneneswnwewswnwwsewswwwwswww
  eeeeeswneeseneeeesewsesweeee
  seseseeseneseseseseswesenwseseesesese
  neneenenesenewnwswnwenenwwnewneenwnene
  eeeseneeseeesenwwsee
  nwsesenweneswneseseseswsewnwesenesww
  wswswwneswwwwswseswwewewswwwnw
  wnwnwnwswnwenwwwnwnwswnwnwnwnwnenwnw
  swseseseseswseeseseswnwswswswseseswnwse
  neseseswwnesenewseswsesenesweseee
  nwwnwwwsenwsenwnwwenwwwnwnwwww
  enenwwwneswswwwswswnwsweeswsewsw
  nwswswswneenwsenwnwswseswswe
  eeeeenesweeneeseeeeeeewsese
  seseseseseswsesesesenwseseseswswsese
  swenesenenenenenwseweneneneneneneenene
  wswswswnweswswswwwwswwnwwswweeswsw
  swsenesewswswswnwseswswswswnewswesesw
  wneswswswnwswswseswswswswseeswswseswswsesw
  swnwneswsewseenweswswnwsewesesenew
  senenenenwnwnenwnwnwnwnww
  eewsewwwseneneseseesweeseneenw
  wwwseweenwswswnwnewwnwsenw
  seswseswseswswseswnenwswnwseseseneswswsw
  nwsenwnwnwnwnwnenwnenwnw
  nwswseseseseseseseswseswseswsesee
  nwseenwwsewewnwwwwnwnwwenenwsw
  swwwwwwwwwwswswwewwsww
  nwswswseswswswswswswswswswseswnwswswseswe
  swswswswswenwswswneswswswswseswswswsesw
  seseneseeenweeeeswwnewseeeeseee
  nenenenenenenenenenwnenenesenewnesenene
  nwnwswnwnwnwswnenenwnenwnwse
  wwseewwnweswwswnewwwwwwnwww
  eeeeesweeewneenwseseeswseenee
  swneeswneeeneeeenenenenenenenenene
  wenwwwwwsewwwwwnewwnwwwsw
  sesesesesesenewsesesweseseswsesesenwse
  wnenenenenenenenenenenesenenwnenenene
  nwnwwnwwsenwwwwnww
  sweswneeswnewwnesweesenwsewwnwse
  wseeswseseeseseesenw
  senewwwsewswwweswwneswewwwwne
  neswneneeswnewnenenwenenenenenenenesw
  eneswneeenenenenenwee
  swesewwseseseseseseseneseesesesenwswsw
  nenesewsewwwnwwwwwnewswwwww
  enewneeneneneswsenenenwnwnwwneewsene
  nwwwwwwwwwwsewwwwsewneww
  eseneneneenwneeseneeewneneneneene
  seswswswnwnesewseswswneseseswswswswsesw
  nesenenwsenesewseseswwneneneenewnenw
  seswnenesenewswseseseswseseswsesewsesenw
  seswsesenesesesesesesesesesesenwsesewswese
  eeswesewnwnwsesweneeenwwwsesenwsw
  nwsewnwnwnwnwnwnwnwwnwwenwnwsenwwnw
  neswsesewneswwneseesesesewwswnwnenew
  swswswswwneswsweswswswswsw
  nwseenwnwnwwnewnwwnwswne
  swswewwnewnewwsewwwswwwwnwwsw
  senwwwseswsweseseswseneseeeswwnese
  sweswswsweswswswwswswswnwswswswnwswswsw
  wnenwnwnenwneswnenenenwenenenee
  nesewneneneneneneewnenenene
  neswnwnenenenweenwnwwwneseenwneneswne
  eeewseseeneeneswe
  nwnenenenwnwnenesenwnenwnwenwneswnwnene
  eeeswneeeeneeeenwweeeneee
  swwwewsenwwnewwwwwnenwnwwnwwsw
  swwewseenewwnwswnwwseenwene
  eswseswwwswswwwswseenenwwswswnw
  wnwnwnwenwnwnwnenwnwnwnwswnwnwnwnwnwe
  wwneeesweneeswwenewwswneseenee
  eeenwseneswneeewenweswneweneene
  eeenwesesweeneswseswenwnenweswnwne
  swseneseswswswwswswswnewswwsweswswswsw
  nenewneneneesweenwneneenenwneseneneene
  nenwnenenwneneswnenenenenenenenenene
  newseseseseswsesenwseseenwseseesesesee
  swsweseneeesewenwseseseeseeeeene
  nesenwnenwnenenenewneneseswnenwnenenene
  eeseswsenesenweeeneweenwsweeee
  swnwwneenwsenwnenenesesesesewwnwnene
  sesesesesewnwsenwseesesesesenwsesenwse
  seneeswsenwsesenwneswwsenenenwnwesww
  enwswseseneseswswswwswseeseseseswnwsenw
  seenwsesewsweeseseseseseseneeesee
  nwnwnwnwnwnwnwnenwnwnwwnwnwesenwnw
  eswsewseseseseseseesesenenenwseesese
  swwswnwenenwwsesewneswseswsesewesw
  wswswneweswswesweneswwwswwswsww
  nwnwnenwnenesenwnwnwnwwnwnenwnwnw
  wseseseswewnwwswnwsenwwnwwnesewnw
  nwnwnwnwnwnwnwnwsenwsenwnwnwnwnwnwnwnwnw
  weseswenwwseseswneenwnwneenwenesene
  neewneweswnwnwewsenwnwesweswwnw
  swswwswswswwwswswswwswswswsweswnw
  swseseeeswwswseseswswseswnwswwsesese
  eenwswsenwnenwswnenenwnenwwnesewnenene
  nwnwwwwwseseesesweneswseeswnwswnwnw
  eewneswswsenwwwnwnew
  weseseseneseeneseeeseeeesw
  esesesesesenwesewesenwseeseseseswese
  swswseswseseswneseseseseswse
  nwsenwswenwnwnenwswnenwnenwweneenwsw
  nwwwwswwwwwwwswnewseeswwwwsw
  seswswseeswseswseseneseseswseswnwswsenw
  nenwwenwswnenenwnwnwneenwnwswnenwnee
  swenewneesweneneneneneneenenenweenw
  wsesesenwsenesenwseseseseseseseswsesese
  senesewseseseseseseseesesesesesesesewne
  eseseseesesenweseeeenwseseeesese
  seeseeswseeewswsewnenewsesenwnwesee
  swwwswwwnewnwwwswswwwswwweswsw
  nweseswesesewseseneseeneesesesesewnwse
  nwwwnwwnwneswwenenwnesewnwsenwnwwse
  nwswnenenenenenenenenenwnenenw
  swwswswswswswswswsesweswswswswnwswsesw
  enenwswnwnwswnwnenewnwnwnwnwnenwswnw
  sewseneeeeweseeeeesenwweewnee
  wnwewnwsewwwsewwwwnwwwewww
  enwneeeseseeseneswnwweeseseswseee
  neseneseeseeenweeesesesewwenwswese
  seseseseseseseenwwsesesenweesesesesee
  swswnwsewneenenwwwnwnwwwwsenenenwswne
  nenwnenenwwneeneswneseswnwnenwsweeesw
  eseeseseeeseeseseeeewee
  nwneneneswenwnenewnenenwnene
  swseseswswsesesenwseeseseseseseseseneswse
  wneseneswnenenenenenenenenenewesenee
  nwenwnwswnwnwnwsenwnwnwnwnwnwsenwnwnwnw
  neswseswswseseswsweswswswseswswswswwsw
  nwnenwenenewneseneewneneneseneenene
  wnwwswswswswswweswnwseswwwswswswsw
  swwswsenwswswswswnwnenwneeeswswsweesww
  enwnwnwnwnwnwwnwswnewwewnwswwwsw
  nwnenwneneneneneneneneeswewne
  nwsenenwnwnwnwnwnwnwwwnenwnwnwsenwnwnww
  neenenwswwswnenweneneswnesenwnwnwsenenw
  seswsenwwsenweswseseseneseeeseseewe
  nwswseseseeeenesewewseseeeesee
  enesenewnenenwwneneneeneswenwwnenw
  nwswnenwwnwnwnwseswnewneswwnenwsenwwnwne
  nenwweeneeswseenesee
  swseseswswswneswnwnwswswswswswwnwswswe
  senweseseseswseseeswnwseseenewnwsese
  eneneeeseenweeeee
  nwseseeswsesesesesesenwseesesweseesesese
  senenenwnewnwnewnwneneswwseneneeswsese
  enwnwswswnewwnwwewswnwswnwwwnenww
  eseseseswwswswswseswswswswswswswswnewe
  seseswwneswswswseseneseswswswswswseswnesw
  enwnwnwnwnwswnwnwnw
  seeseeeeeeseeeweseweseseene
  eeneswweswnenweenwsweenwe
  eswswwwwnwswswwsewwswwswswwnwswnwe
  neswwswnwswswswswswswsweswswswswswswswsw
  sewnwseswnwenewneeneewneswnewnwnw
  sewswwseseswswnwseswsewneeswswswswnese
  wswswswswswswswswswnese
  newwswwewwwwseswsesewwwnenwwsw
  wwswswewswswswnenwswsenwswweseew
  wnwwwwwewwwnwwwwnwwnwsewnenw
  nwnewnenesweswenenwsesewneneeneneneene
  seseseswsweseseeneseseseseseesenwnwse
  nwneswseneswnwwnwseneseseswswseseswnwsw
  nwneswwnweneewnwnwenenenwnwnwsenenewnw
  eswnwnesewenwnweseeneseseseswwnenw
  eweeseseeneeswneseeeeseeseeenwse
  seseseseeseeesewsesesewseneseseesenese
  ewsweswswseswsweneswnenwnwseswswsewsw
  wwnwnwnwsewnwnwnwwsenwnwnwnwnw
  wsesewnwsenwwswwwnwnewwwsweewse
  ewwswwwweswwwwwswwnwswwsww
  seswsewewnewseenenenwwsenenesenenww
  seswseseseswswswnwsesenesesesewswsese
  eeeeeweswenwe
  eeneeeeswneeenenwe
  sweeenweneeneeeeeeeeeeew
  neswneneneenwneneneeneneswnenenenenenene
  seseseseneswswnwseseseswseseseswseseese
  eseenenenwwseseenwewwweewsese
  nwnesweeenenweneneeeneneseeee
  wwwewswwswswwswwswswwswww
  neswseseneswswseseswswswseseswswsese
  wesesenesenwnwnwswnwwswnwneneseswsee
  neeseseneeneswwnwnewnee
  nwnwnenenenwswnenenwnwnwnwnw
  sewnweesweseseenesenwseeenweswesene
  eneesenesweeswneeenwneewneswwnenenw
  seseseseewswwnwseesewswneseswswnwesw
  nwnenewewsewswnwsewwwswwnwenenwe
  neswnwsenenwswnwenwnesewnwnw
  newnenenewneneeneneseeneeeeenenesee
  enwweeseneeeeeeseeeseeeesw
  swseseseswswswswseneswneswswswswwwswse
  nwseseeeseseeseseseeenwseswesesee
  swswneseseeneswnwnenwwswenwenwnwnenw
  newnwswnwnwnwnwnenwnenwwnwnwenwnwesenww
  sewseeseeseseeseeeneeeseseweesene
  enwnwseswseswswsesw
  sewwweswnewwnewwnewwswwseww
  nenenenwnwsenwnwnwnwnwnenenewnwnwnwsenwsw
  swnewwseneswswswnwewswwwnesenesesesw
  sweeeeseeeeeenwweese
  eeeeeeeneeeeeswneee
  wwwwwwswsenesenwwsenenwnwwnwww
  neswneswswwswswwwswswwsesewwswwsw
  sewwnwnenenwnwseewnwseswenwnwswwnw
  wnwnwwwwwnwsewewwnww
  swswwswenenwswnwnwswswswswswesweswswsww
  wnesweswneneneneneneneneneneneneneenee
  eswswswswnwseswseswseseswseswsenwswswsw
  sesenwswenwnwwwnwwneneswnwwsenwnwene
  wswwwwnewswneswwwneswwswwseseww
  wseseswswneswswseswswswsw
  nenenwnwnwswnwnenenenwsenenenwnwnwneswse
  wsewenwwwnwnwnewwnwnw
  eeeneneeeneneenesesww
  neeewwsweeneenwwseeenweswnesw
  sweneswswswswswswswswswwswnenew
  nenwnwnwnenwswnwneswnwnenwnenenwnw
  nwswnwnewnwenwnwnwwnwwnwnwnwenwnwse
  neneneeenwnenwenwsesweeeeeeeswee
  eseswswseswsewswswsesese
  wwseenwnwwswseswnewswnwwwwewwsew
  eeseeeeeseweeseseeesesewese
  neeswswswswswswwwswneseswswswwwswwswsw
  swwnwnwnwewwnwswnwenwnwwnwnwnwwenwsw
  nwneeneeneeeswnenenenwneneeesweeswne
  swneweeeesewenwswesweeenenwnee
  eswwnwwesenesenwwwnwnwnwnwwwswnw
  seweseswswswnesenwswswswneswswwswswsese
  nesesenenwsesewseenwswwsesenwswnwsesee
  sesewseweseseeseeweeeweneene
  enwseeswsenweeeeeeeeeeeeee
  newwswwnewsenwsewseswnwnwwnwwwnenw
  swswwwwwwswwnewswswswseswwsw
  neseseseseeswswsenwseseswseswsesesese
  seseseseswseseseneswseswsesesewswswse
  newnwnenwswnwnwswnenwenwnwnwesenwnwnwnw
  sesenesweswwnwswswswwnenwse
  swnenewwwneneenewenweneenenwnwnene
  nwnesenwnwnwnweswnwswnwwnwnwnwswwnwnwe
  eeeeseneeeeeenweeeneww
  seseeweeeweeseseeseesenwewese
  nenenwenewnwneswnenenenenenenenenenwne
  eeenesenenwneeswwwswswnw
  enwneeenenenenesweneseeeeneneewne
  swswwnewswwwswneseseeswswswswneswsw
  swewseseswseneswseseswsese
  wseseseneseseesesesesenw
  seseseesenwseeswswsesesesewseswseswsesw
  seseeesenweseseeesesweseeese
  sesewswseeswnwenweeeeeeweeee
  eswenwsenenwseeswseseswnweweseesesenw
  wnenewnweseseeseesesweseseeseese
  enwnwnwwwnwnwswwsenwswnwswwenenenw
  seneswswsewswweswswnwswnesweswseesesw
  swenwesesweeewnwseenwenew
  swwnwwwwwenwwwwsenwnwwwnwww
  wsewwsewwswwwnewneeneneneswsew
  seewnwseseeneseeseseswsewseseeese
  seseseseseenwenweeeseseesesesesee
  neneneeneeneneweneswnene
  wswneswswnwswsweeswwnwswwsw
  swsenwseeseswsenwseswswswswswswswseswseesw
  nwnwnwnwenwnwnwnwnwnwswswnwnwnwnwnwnenw
  neneenenenenesweneneneneeeneseenenw
  wswswswswswnwswswseswsweswseseneswswnwe
  neneneswnwnwneneswnwnwnwnenwenwnene
  wwnewwwnenwnwnwwnwsenwwwwsewneswnw
  neseeswseseseseseseneswwsesesesesenwe
  eneeeesweseenesweeeeeenenwnw
  swswneswwswswwswnweswswswwswwswswsw
  nwnwewsenwnwsenwswwsenenwnwnene
  weeneswwneneswwnwwseswseww
  swnenwnwnenwnenwnweswnenwnenwnwsenenenwnw
  wnwnwswnwnewewneswsewewwwswwnw
  eneeneeneeeeneeeesw
  nwnwnwsewwswnwnwwwwweenwnwwww
  swwswwswnwswwswwswswwswseneseswswwnw
  swswnweswnwnwsweswswswswseswenewswswwnw
  neeeneneneneswneseneseneneenwenenenwe
  sesewseseeseseseesesenesesee
  neseeeeeenwneeeneeenesweeee
  sewneseesenwenewnwwsewswnwnwswwww
  wwsenwwnewnwwwswwewwwwwww
  newwneeswwwwwwwswwwswwsewwsw
  senwnwseswswseswswswswswswswswswenwsesw
  nenenenweneeneewneseweswenesenenwne
  nweneenwesweneswsweneeeenenenee
  neneweeneseneneneseeneeswnenenwnenene
  swseseeneeewsenwneseeneneseewww
  sewnwnwnwwnenenwnenwsenwnenwnwnwsenwnwne
  eswseeenenenwneeeeeeeneeneee
  swnenenenwnenenenenenenenenenenesenene
  enwseeeesweseweeeseesenweeww
  swswseswswseswsweseswswwsenweswnesenwse
  sewnenenweseeseeswneeswswseswneseese
  newneneeneeeneneneneswneneseeneee
  swnenwneneweeeneswneswsewnenw
  nenwwnwnwnwwsenwnwnwnwnwenwse
  seesenweeseeseeewnweneswsweeee
  nwwnwnenenwnwwwswnwwnwnwwnwwsewnww
  nenwneneenwnwnesweneneneswnwnenwnenenene
  swswswseswsweswswswswswswnwswswswnwswsw
  sesesenweseseswnwseseseseswseseseswswse
  seesesenwnwseseeseseseseewnesewnwese
  swseseswwswswswseneseswseeswseswseswswnwsw
  swseswsweswnwswnwswswseswswneswswswswsw
  enewneneneenwswseneneeswneeneneee
  nwnwwnwnenwnwseww
  wwnwswswnweswswwswesewwwswswwsww
  seswswswswsewswseneswsw
  nwsenenenwneneneeenenewswnenesene
  swswswswnwswseswswseswswswsw
  nwnwneswnenwnenenenwnenwnwnwnwnwnenw
  seseseewwsesenewseseseewnwesesese
  nwnwenwnwnwsenenwsenwneswnwnwnwnwnenwnene
  eneeneenwswneneneeneeewneeeee
  eeseeseseneseseseweseesese
  neneseswnwneneneneswnwnwenwnenenwnenwnene
  swswswnwswseseseseseseswseneswsewswsesesw
  seswsesweswneswseswneswnwnwwwswswenwsw
  seseeeeewneeneeewenenenenwnene
  swswswswweswswwswseswneswswswwswswswe
  senweswnwswnwnenwswenwenw
  nenenenesenenewnenenenesweneenenenew
  senwneneseneswnenwnenwnwswswneneewnwesew
  swseswnwesweseeseswnwnewswswseeswswnw
  eenwswnwneneswsweeeeeeeeeee
  weenweseeseeeesese
  nwswnenwsewnwnwewnenwnwnwwswwnwnesw
  neesweeeesweeeswwneneeesenenw
  wenwwnwwswwwnwwsewwwwwnewww
  nenwwnenwswnenenwnesweeswenwnenwwne
  seseneseseswseseseswsesenwseseswseesese
  seeswseseenwnwwnweswswsweswsesenwswsw
  seseeswwseswesenw
  eseswswseseneswnwnwwseseneneeweswwnw
  swneswnwnwnwnwnenwnenwswnwnwnwwwwsweew
  sesewwneseswseeesesewsesesenesesese
  sweswwnwseswnwwnwswwswswwsewwnwsesw
  wswwenwneswnenewsesesenwseeeswsesesw
  nwnenwwswneswwnwenenwsenwenenenenwnwe
  nwwnwwnwnwnwwnwswwnwwneewwnwnwnw
  sesesesesweswswseseseseswswswswnwneswsw
  enwswsweseswwseneseswneeeeseenesene
  seseneewwnwwwwwwwwnwswwswwnew
  nesenenenenenenenenwneenenenenewnenene
  wnwsenwnwnenwsenwnwnewwnwnwnwswnwnwnw
  nwnenwnenenenwnenwnwnenwnenwnenwwseswne
  wnwnwwwwwwenewwnwwwwwsewwnw
  nwnenwnenenwnwnwnenwwswnenwnwnwnenwnesenw
  seswswswswswswswswswnewweswwswswnwsw
  nweswnwsesesenweseeeseseeesese
  swneesweeeeeesweeeenweeeenee
  seseseswseneeesesee
  swswseswwseseswswneseseswseswsesenwsesese
  swnwswswwswwswwswseneseseewswnewsw
  neseswswseseswseswseswnwswsesenwwse
  swwwnewnwwwwswwwewsweswww
  eseeeseneeseeeeseeewseeewsese
  nenenwneenwswnwnenewnwnenenenenenwnene
  wseeneeseeeeewneneeneeeneee
  wsenwswsenwneswnwwweswenenwseswsenw
  enenenwneenwnenwneneneneswnwnenwnenww
  nwsenwneneneesenenewnenewenenenenewne
  wwwsewweswwwwwwnwwswwswwnwsw
  wwnwwwenwwswwwsewwwwwwsww
  wswneeseswwswewenwenenwswnewseew
  neswseswseewseeweenewenenenwsee
  nesenwwwwnwwsewwsewnwsewnewww
  eneenweeesweseeeeeeeenenee
  neseneesweseswneneswewsenwsenwwnewsw
  enwswnwnwnenenwnwnwnwnwnwnenwnwnwnwwnw
  neenweseseeeenewnwseeweeeew
  nweeseeseseesew
  wnwnwwenwnwwswnwwnwnwwwnwweswnwnw
  eewenweseeeneeeeweeeesee
  nesenwsweeseeeswswneee
  neneeweeneneeseneneneneeeswne
  swwwswneseseseseneseesesesenesewnesew
  nesweseeneeeneneneenenweeeeee
  eeeeeeeenweewswwseeesenenw
  wwnwwwewwnewswwwwswwwsewwsw
  neneneeneneneneneneswnenenwne
  sweswswenwswweswswseneswnwswsewsww
  enweeeeseeeeswe
  seeseseneseneeswswnwswswwwswswneewne
  wsesesesenwneeneswnewseseeesesesee
  neeeeeesweeeeeeeswnweseee
  sesenwsenweswseneseseswse
  nenenwnenenwnwnwwnwwnwneseneenwnwnenw
  eeswesenwsenweeeeseeeeesewee
]

dummy_input = %w[esew]
dummy_input2 = %w[nwwswee]
dummy_input3 = %w[
  sesenwnenenewseeswwswswwnenewsewsw
  neeenesenwnwwswnenewnwwsewnenwseswesw
  seswneswswsenwwnwse
  nwnwneseeswswnenewneswwnewseswneseene
  swweswneswnenwsewnwneneseenw
  eesenwseswswnenwswnwnwsewwnwsene
  sewnenenenesenwsewnenwwwse
  wenwwweseeeweswwwnwwe
  wsweesenenewnwwnwsenewsenwwsesesenwne
  neeswseenwwswnwswswnw
  nenwswwsewswnenenewsenwsenwnesesenew
  enewnwewneswsewnwswenweswnenwsenwsw
  sweneswneswneneenwnewenewwneswswnese
  swwesenesewenwneswnwwneseswwne
  enesenwswwswneneswsenwnewswseenwsese
  wnwnesenesenenwwnenwsewesewsesesew
  nenewswnwewswnenesenwnesewesw
  eneswnwswnwsenenwnwnwwseeswneewsenese
  neswnwewnwnwseenwseesewsenwsweewe
  wseweeenwnesenwwwswnew
]

pp "Part 1: #{part1(input)}"
pp "Part 2: #{part2(input, 100)}"
