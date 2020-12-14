class DataDock
  MASK = 'mask'
  MEM = 'mem'

  def initialize(input)
    @input = input
    @mem_values = {}
  end

  def decode
    @input.each do |value|
      if value.include?(MASK)
        @current_mask = get_mask(value)
      else
        memory, bits = get_mem(value)
        result_value = apply_mask(bits, @current_mask)
        @mem_values[memory] = result_value
      end
    end

    @mem_values.values.sum
  end

  def decode_v2
    @input.each do |value|
      if value.include?(MASK)
        @current_mask = get_mask(value)
      else
        memory, bits = get_mem(value)
        result_value = apply_mask_v2(memory.to_s(2), @current_mask)
        result_value.each {|x| @mem_values[x.to_i(2)] = bits.to_i(2)}
      end
    end

    @mem_values.values.sum
  end

  private

  def get_mask(value)
    value.split("= ").last
  end

  def get_mem(value)
    # "mem[8] = 11",
    mem_str, decimal = value.split("=").map(&:strip)
    memory_location = mem_str.match(/\d+/).to_s.to_i
    binary = decimal.to_i.to_s(2)
    [memory_location, binary]
  end

  def apply_mask(bits, mask)
    new_bits = '0' * (36 - bits.length) + bits

    new_bits.length.times do |index|
      if mask[index] == 'X'
        # noop
      elsif mask[index] == '1'
        new_bits[index] = '1'
      else
        new_bits[index] = '0'
      end
    end

    new_bits.to_i(2)
  end

  def apply_mask_v2(bits, mask)
    new_bits = '0' * (36 - bits.length) + bits
    memory_array = ['']

    new_bits.length.times do |index|
      if mask[index] == 'X'
        tmp_array1 = memory_array.map { |x| x + '0' }
        tmp_array2 = memory_array.map {|x| x + '1' }
        memory_array = tmp_array1 + tmp_array2
      elsif mask[index] == '1'
        memory_array = memory_array.map {|x| x + '1' }
      else
        memory_array = memory_array.map {|x| x + new_bits[index] }
      end
    end

    memory_array
  end

  def apply_value_to_memory(memory_array, value)

  end
end

def part1(input)
  dock = DataDock.new(input)
  dock.decode
end

def part2(input)
  dock = DataDock.new(input)
  dock.decode_v2
end

input = [
  "mask = 11110X1XXX11001X01X00011001X00X00000",
  "mem[28496] = 122879146",
  "mem[62261] = 32295460",
  "mem[493] = 1117432",
  "mem[52235] = 813357",
  "mask = 1X0111001110011X1011010110X0X0000100",
  "mem[8994] = 14305",
  "mem[34732] = 37943",
  "mem[20855] = 1556305",
  "mem[13410] = 14988",
  "mem[32276] = 32738",
  "mem[2228] = 3149408",
  "mem[31631] = 1233",
  "mask = 10011X0X11XX0010X0XX00001000X000100X",
  "mem[37384] = 36816",
  "mem[50366] = 4863299",
  "mem[54732] = 2809",
  "mask = 1101101001X000001X1X11001000X1100100",
  "mem[54859] = 3282",
  "mem[28888] = 4510",
  "mem[1970] = 43265503",
  "mem[26507] = 431322090",
  "mem[52936] = 15708",
  "mask = 1001X000011001X0101111X01101001XX0X0",
  "mem[55315] = 1244",
  "mem[996] = 16606304",
  "mem[33560] = 51327154",
  "mem[62976] = 214",
  "mem[38483] = 1247",
  "mask = 1001000X0111XX1101X1X1110011X111000X",
  "mem[29056] = 6114031",
  "mem[43840] = 53837995",
  "mem[792] = 96146",
  "mem[54993] = 397780",
  "mem[21841] = 68218295",
  "mem[21807] = 247938216",
  "mask = 1X0110X001110011XXX10101X01X001X1101",
  "mem[42679] = 47607",
  "mem[32352] = 45087",
  "mem[40900] = 58663424",
  "mem[13233] = 890",
  "mem[38085] = 243713",
  "mem[33164] = 53393",
  "mask = 1X01001001110000X10101X0000X0X100001",
  "mem[37053] = 982127",
  "mem[11500] = 1038946",
  "mask = 10010X1X01100110101101XX10010X110X11",
  "mem[30594] = 89921232",
  "mem[14439] = 12553808",
  "mem[48894] = 525879475",
  "mem[59355] = 241595",
  "mem[35032] = 3037",
  "mem[42800] = 582558",
  "mem[38986] = 6250854",
  "mask = X001X01001X101X00X011110000101100000",
  "mem[21166] = 12947223",
  "mem[59468] = 7426127",
  "mem[31693] = 23713925",
  "mem[50226] = 1955",
  "mask = 1X01X010XX1X0000X11111X01010X1X00100",
  "mem[25586] = 11522",
  "mem[37651] = 9964",
  "mem[52236] = 3269458",
  "mem[25564] = 855216",
  "mem[13888] = 47133652",
  "mem[6216] = 295582935",
  "mem[38085] = 1030124",
  "mask = X1010XX0X11010000XX1000X000110X10001",
  "mem[37312] = 769892",
  "mem[44553] = 39935",
  "mem[8664] = 2078",
  "mem[38810] = 4723422",
  "mask = 1001000X0111001XXXX111110XXX11010X00",
  "mem[14168] = 440",
  "mem[184] = 7742149",
  "mem[56255] = 223802814",
  "mask = 100100XX011100100X0X1000X01000011100",
  "mem[52991] = 22485",
  "mem[996] = 83278",
  "mem[26332] = 475",
  "mem[32941] = 4463",
  "mem[32157] = 182264843",
  "mem[15541] = 5197",
  "mem[29396] = 3054",
  "mask = 1XX10010001X00100111111X01001X111110",
  "mem[58063] = 220909",
  "mem[64200] = 217342",
  "mem[62205] = 57377569",
  "mem[6527] = 23955",
  "mem[5637] = 2701",
  "mask = 100XXX0001X001X1X01100011000XX000011",
  "mem[62525] = 9958",
  "mem[27750] = 270520",
  "mem[13733] = 45389110",
  "mem[16216] = 865919078",
  "mem[13880] = 16730603",
  "mem[7477] = 9819",
  "mem[62795] = 686530",
  "mask = 00010101X111X01010110011000011X0X0X0",
  "mem[39797] = 491650",
  "mem[45553] = 1907",
  "mem[57186] = 518",
  "mem[33017] = 4842627",
  "mem[29677] = 78117467",
  "mask = 10X1X0000110X1110011011X1X0000001011",
  "mem[4908] = 932",
  "mem[50496] = 284837",
  "mem[30932] = 668",
  "mem[33716] = 38203",
  "mem[9473] = 35636204",
  "mask = 100X0001011X0111011111010X11100X000X",
  "mem[1190] = 947843",
  "mem[13122] = 508226085",
  "mem[42840] = 534125021",
  "mem[12720] = 9630921",
  "mem[15565] = 64233130",
  "mask = 10X1000011110000X0110X001XX101110000",
  "mem[45798] = 62463",
  "mem[9152] = 3098",
  "mem[21343] = 2323768",
  "mask = X00X0001X1110010001101X0X10111111000",
  "mem[62932] = 985789",
  "mem[184] = 27943",
  "mem[21343] = 6809205",
  "mem[27463] = 720666",
  "mem[31517] = 410656",
  "mask = X00X001010110010010X0111101X010X0000",
  "mem[33725] = 953827",
  "mem[31337] = 52073107",
  "mem[24780] = 3747",
  "mem[14664] = 2978878",
  "mem[54462] = 1743",
  "mask = 101100001X1100000011X010X01X00100X10",
  "mem[53968] = 2522890",
  "mem[48118] = 22306106",
  "mem[62157] = 18708031",
  "mask = 1001X0XX0111X01X10111X00X0011000X10X",
  "mem[33164] = 96936963",
  "mem[916] = 123092",
  "mem[5857] = 105415",
  "mask = 100X0X0011X10XX010110110110101X10XXX",
  "mem[17056] = 708",
  "mem[42735] = 56971",
  "mask = 01X11XX1111110101X1X00010111XX00010X",
  "mem[255] = 103917161",
  "mem[24313] = 9303",
  "mem[39248] = 34494",
  "mem[17795] = 85207",
  "mask = 1X1100X1X1X10010010X011010100100X000",
  "mem[33164] = 3447",
  "mem[15952] = 47594490",
  "mem[1993] = 11276",
  "mask = 1001X0100111001X011101010X11X0000101",
  "mem[65389] = 358768373",
  "mem[5922] = 21201821",
  "mem[38483] = 8968",
  "mem[24744] = 270318",
  "mem[44666] = 5613326",
  "mask = 1001X0X0XX1X0X00011XX11010101010110X",
  "mem[31783] = 3732",
  "mem[28249] = 60160",
  "mem[8137] = 68398",
  "mask = 10010000X1X10XX01011010X0X111001X000",
  "mem[33164] = 14211929",
  "mem[1157] = 39792",
  "mem[32624] = 79716",
  "mem[63222] = 21016026",
  "mem[59282] = 954891645",
  "mem[46536] = 2174620",
  "mem[58276] = 3285",
  "mask = X00100010X1X001010X111XX000111011000",
  "mem[45798] = 6023",
  "mem[45146] = 24399107",
  "mem[20872] = 5264",
  "mask = 1001000X01X1101X101X1000100X000001X0",
  "mem[2436] = 594",
  "mem[60642] = 118",
  "mask = XXX1XXX11111101010110XX01X1110010101",
  "mem[43703] = 111003459",
  "mem[53069] = 971",
  "mem[6636] = 966034",
  "mem[47713] = 3508879",
  "mask = 1001000011110110X011X11X0011000XXX00",
  "mem[5502] = 11044565",
  "mem[28161] = 102792785",
  "mem[37274] = 552",
  "mem[1025] = 556926",
  "mem[13079] = 1331",
  "mem[49077] = 379631",
  "mask = 10011X00111X011110X10100101X1X00X0X0",
  "mem[13233] = 8774064",
  "mem[13875] = 27148",
  "mem[4988] = 234997",
  "mem[61445] = 413",
  "mask = 11010010XX10100X0011X00XXX00X00100X0",
  "mem[33716] = 248058226",
  "mem[2385] = 689005228",
  "mem[12849] = 635348",
  "mem[19552] = 364123",
  "mem[5048] = 8581432",
  "mem[35793] = 125558802",
  "mask = X0X110000100010X10X1010101001X10X100",
  "mem[65018] = 2357446",
  "mem[8956] = 364396106",
  "mem[25714] = 14052",
  "mem[14339] = 519539",
  "mem[28560] = 15646102",
  "mem[15778] = 26031",
  "mem[29947] = 535619",
  "mask = 1101001010XX1X01X0110000X0010011X010",
  "mem[32112] = 3746",
  "mem[25979] = 687775",
  "mem[2874] = 560632068",
  "mem[8517] = 221678804",
  "mem[8294] = 21059",
  "mem[61154] = 1530796",
  "mem[27146] = 21164",
  "mask = X0110100010101101X1101000X0010X0X000",
  "mem[20405] = 426362",
  "mem[1157] = 369152539",
  "mask = 1X01000X011XX111011XXX110011X01X0000",
  "mem[37120] = 200",
  "mem[41360] = 6127",
  "mem[58276] = 7317",
  "mem[57680] = 32092",
  "mask = 1XXX000011X1011010X101101010100XX000",
  "mem[21718] = 15085",
  "mem[21468] = 1096",
  "mem[42143] = 180407337",
  "mem[42725] = 103143",
  "mem[26037] = 3418537",
  "mem[44240] = 95963584",
  "mask = 0XX000XX0111X0100X110XX10011101X1101",
  "mem[17484] = 22276",
  "mem[37470] = 59555570",
  "mask = 0X01X0XX010X11111X0101X01X01010110X1",
  "mem[50115] = 40783124",
  "mem[25094] = 589",
  "mem[21308] = 6670",
  "mem[45293] = 124853",
  "mem[5761] = 1573",
  "mask = 100100000X010000101X010000010X000X00",
  "mem[45798] = 5885",
  "mem[60733] = 66990973",
  "mem[19504] = 1664",
  "mem[917] = 26840163",
  "mask = 100110X1011X1010X011100010110000X10X",
  "mem[31631] = 13676",
  "mem[53968] = 10834507",
  "mem[30594] = 17285061",
  "mem[24079] = 52275785",
  "mem[33428] = 250814863",
  "mem[18370] = 7376",
  "mem[25322] = 2165016",
  "mask = X1X10XX011110X110110001X00010010X10X",
  "mem[62795] = 452850119",
  "mem[61969] = 191229",
  "mem[47890] = 2184",
  "mem[65456] = 317",
  "mask = 1101001X00X0X0000X11X1X1010X011000XX",
  "mem[60814] = 3464536",
  "mem[24683] = 3841479",
  "mem[27801] = 20001",
  "mem[22640] = 885",
  "mask = 100X00X001X1001X011110X00101X101XX01",
  "mem[16212] = 739746125",
  "mem[60733] = 56658758",
  "mem[21898] = 9618927",
  "mask = 1000XXX00100010110110011110X10XX001X",
  "mem[24084] = 29140570",
  "mem[29808] = 40803",
  "mem[63496] = 19816",
  "mem[65197] = 3728",
  "mask = 1X0110000X1X1111110101101000X0110X01",
  "mem[16116] = 1010",
  "mem[26150] = 31541461",
  "mem[35715] = 2674",
  "mem[38986] = 3747344",
  "mem[4988] = 149164",
  "mask = 10011X10011100X10011010X011X10001101",
  "mem[2241] = 3386946",
  "mem[4694] = 48652179",
  "mem[47835] = 13389799",
  "mem[63403] = 747876",
  "mem[63312] = 455292",
  "mem[32352] = 144809",
  "mem[38504] = 270482",
  "mask = 100110X001X0X10X10X1010111XX0110000X",
  "mem[51554] = 45323634",
  "mem[56133] = 235458",
  "mem[38483] = 204623",
  "mem[24806] = 3668",
  "mask = 1X01X000XX1101X1011001X10X0110110000",
  "mem[7796] = 1791",
  "mem[58913] = 6047",
  "mem[25120] = 38172",
  "mem[15065] = 418",
  "mem[24806] = 261219",
  "mem[8258] = 476",
  "mem[64053] = 54588494",
  "mask = 1X0XX0010111001X0011X011001000011000",
  "mem[53968] = 423903129",
  "mem[21349] = 2647137",
  "mem[31517] = 3585",
  "mask = 10X0X010010001X11000XX0X11000X110000",
  "mem[50050] = 6227",
  "mem[46260] = 9258",
  "mem[11056] = 312913",
  "mem[8137] = 13263",
  "mem[56042] = 1562420",
  "mem[31633] = 10828",
  "mask = 1001000101X10X11101100X010011001XXX0",
  "mem[109] = 64416",
  "mem[33532] = 912488995",
  "mem[49949] = 7342",
  "mask = 100100X00X11001101X110100X0101X1XX00",
  "mem[53652] = 762",
  "mem[27821] = 16182",
  "mem[63222] = 1973429",
  "mem[54488] = 1867910",
  "mem[47023] = 2651",
  "mem[22348] = 197797",
  "mem[47953] = 264",
  "mask = 01010X00010X111X100110X0110X11XX0001",
  "mem[49944] = 7483",
  "mem[48355] = 9970614",
  "mem[11768] = 4137531",
  "mem[49992] = 158624",
  "mask = 1X0100X0011X111X01010011011X01X11000",
  "mem[1453] = 1587",
  "mem[21358] = 518966",
  "mem[33663] = 36033",
  "mask = 1X0X101001X0010X10X111010010010XX010",
  "mem[30932] = 374511",
  "mem[42432] = 136",
  "mem[17842] = 2831",
  "mem[53043] = 24388",
  "mem[21652] = 1489",
  "mask = 10010000011XX1X01011X0X111010X01X111",
  "mem[4130] = 3235",
  "mem[5393] = 428043752",
  "mem[61907] = 123036862",
  "mask = X101X000X1110111X11X1011001X001101XX",
  "mem[55424] = 982",
  "mem[12576] = 29997",
  "mem[14339] = 3059",
  "mem[61371] = 267595737",
  "mem[823] = 1609",
  "mem[35021] = 1382",
  "mem[12706] = 87331694",
  "mask = X0011000X1X1XX111X010111XX110X110000",
  "mem[22424] = 279",
  "mem[51180] = 295550182",
  "mem[31115] = 1850",
  "mem[12301] = 73241049",
  "mem[33164] = 3871",
  "mask = 01011001X10111111X0111110001011X1X01",
  "mem[52398] = 201274372",
  "mem[55800] = 28230327",
  "mem[5502] = 87426428",
  "mask = 100100X001110XX000010000X011X11X010X",
  "mem[33532] = 66980",
  "mem[36494] = 1648",
  "mem[62205] = 121045",
  "mask = 1011X01011111X001011101111X0X0X00001",
  "mem[1968] = 1754627",
  "mem[15833] = 18240875",
  "mem[17309] = 198847487",
  "mask = X0XX00010111X01X0X111X111X1011110000",
  "mem[9152] = 84981",
  "mem[13024] = 8632028",
  "mem[52235] = 2771863",
  "mask = 010X1001010011111101110X1X111X011011",
  "mem[36263] = 250349",
  "mem[51076] = 173684668",
  "mem[33663] = 748056",
  "mem[41406] = 3701",
  "mem[39943] = 57465561",
  "mem[35274] = 274579",
  "mem[23794] = 1882",
  "mask = X0010000011100XXX1110111001001110000",
  "mem[53968] = 215965864",
  "mem[8480] = 710284",
  "mem[52105] = 48723601",
  "mem[29947] = 1008060704",
  "mask = 100100X00X1XXX10X01111011XX10111X010",
  "mem[64640] = 29613000",
  "mem[30909] = 1529",
  "mem[16737] = 2346",
  "mem[51743] = 17672",
  "mask = 1001X010XX1100X001X1X111X0X0000X1100",
  "mem[56016] = 5032",
  "mem[20653] = 54205997",
  "mem[42679] = 15900742",
  "mem[16216] = 20765",
  "mem[39391] = 1810",
  "mem[1438] = 64806160",
  "mask = X00100X0011X0010101100011111X0X0110X",
  "mem[62001] = 2293734",
  "mem[51570] = 27410324",
  "mem[31337] = 31818",
  "mem[33164] = 463505",
  "mem[6180] = 6643",
  "mask = 1X010010X01010X00011XXX0000X01X000X1",
  "mem[16186] = 127457",
  "mem[23827] = 140497823",
  "mem[14322] = 3676",
  "mask = 10X10000110X011XX0X1101X10X1110X1000",
  "mem[28416] = 109560691",
  "mem[48751] = 572",
  "mem[30535] = 179917",
  "mem[51179] = 6268",
  "mem[64835] = 12137",
  "mem[43669] = 736",
  "mem[62926] = 4115424",
  "mask = 1X010000010100X010X1X10000X111X10000",
  "mem[8480] = 2963",
  "mem[61456] = 513016",
  "mem[49992] = 709344",
  "mask = 11010X00011X01110X10X0X000XXX0X00000",
  "mem[37403] = 6499",
  "mem[21296] = 51167",
  "mem[23652] = 4199949",
  "mem[42179] = 48597",
  "mem[16348] = 1690",
  "mem[4036] = 93033986",
  "mask = 10X100XXXX111XX010111001X11100010001",
  "mem[23410] = 2403013",
  "mem[20872] = 91570",
  "mem[33663] = 323614",
  "mem[57205] = 5579",
  "mem[44209] = 16475050",
  "mask = 1000010011X101101011XX101110110110X1",
  "mem[41225] = 34201",
  "mem[26085] = 225",
  "mask = 1X01000X1111X0X01011100X000111XX0110",
  "mem[52925] = 2762745",
  "mem[61937] = 234765",
  "mem[9152] = 135872",
  "mem[62192] = 86367797",
  "mask = 100X0000110101101011010X110011X0X001",
  "mem[11499] = 777007112",
  "mem[10001] = 24795",
  "mask = 1001X010X1X1001001010X01X01111001101",
  "mem[5827] = 36",
  "mem[40561] = 27397",
  "mem[44014] = 24725086",
  "mem[15240] = 856132753",
  "mem[25486] = 122947210",
  "mem[10913] = 1208874",
  "mem[31115] = 338582297",
  "mask = X010000101XX10X10111X101X0X0XX111010",
  "mem[60347] = 925",
  "mem[42179] = 22624563",
  "mem[64211] = 115718",
  "mem[41056] = 101406007",
  "mask = 1X0100X0111101010110X0XX00X110X10X0X",
  "mem[3567] = 248440",
  "mem[43297] = 3245",
  "mem[56133] = 13350",
  "mem[19206] = 24622",
  "mem[17296] = 9874",
  "mem[4430] = 12106",
  "mem[13899] = 1007",
  "mask = 00000001X1110010XX11000111X0100X0000",
  "mem[18301] = 57682",
  "mem[5637] = 3651",
  "mem[4204] = 174",
  "mask = 10X100100111X1X0000X1000101100X1X100",
  "mem[64125] = 903",
  "mem[19166] = 874",
  "mem[32923] = 14459",
  "mem[11815] = 4710371",
  "mask = X10100X000101010X0111X0111000001XX01",
  "mem[49963] = 6202",
  "mem[50226] = 1293",
  "mem[16805] = 785963",
  "mem[36474] = 1712",
  "mem[41464] = 127690959",
  "mem[7796] = 229787",
  "mask = X001X01001XX101010111000000100000100",
  "mem[23141] = 395681",
  "mem[32112] = 16739306",
  "mem[51326] = 11867463",
  "mem[17309] = 127987",
  "mem[21841] = 1262419",
  "mem[40166] = 43597",
  "mask = 110100X011X010XXX0111001X001110X00XX",
  "mem[4577] = 37220",
  "mem[48751] = 759375343",
  "mem[61421] = 2088",
  "mask = 101100111011101010111X0X1X000111X1X1",
  "mem[59278] = 121317",
  "mem[12296] = 256848",
  "mem[5984] = 770548",
  "mask = 101100XX1111101X10110X011X111X010X0X",
  "mem[20405] = 15",
  "mem[52642] = 183027",
  "mem[41648] = 1832603",
  "mask = 1001001X001010000011X100001X11100X0X",
  "mem[7022] = 839",
  "mem[56720] = 17045",
  "mem[38260] = 107128",
  "mem[63473] = 44276",
  "mem[43] = 4895197",
  "mem[54588] = 63",
  "mask = 10X10X0XX10101101011010X0X00100X0100",
  "mem[1025] = 195457",
  "mem[38808] = 11614153",
  "mask = 100110X0X1X1001XXX111001001XX00X1000",
  "mem[18861] = 88662",
  "mem[39313] = 9810008",
  "mem[41860] = 54612",
  "mem[50913] = 356833256",
  "mem[4910] = 1969",
  "mask = 0X011XXX1X1X01111110101100X1001000X0",
  "mem[1655] = 783",
  "mem[36884] = 80188745",
  "mem[32624] = 37276",
  "mask = 1X00X0100100010110XX01X0101110110000",
  "mem[34530] = 17739279",
  "mem[29750] = 3920",
  "mem[20436] = 1163",
  "mask = 100000001101X000X01X0X101111XX0000X1",
  "mem[10993] = 525443409",
  "mem[30909] = 918",
  "mem[16631] = 5671",
  "mem[46190] = 1006",
  "mem[49551] = 563314224",
  "mem[3536] = 847707",
  "mem[65309] = 197434302",
  "mask = 10011010110100100X0X0111XXX111X01XX1",
  "mem[14662] = 32542216",
  "mem[36119] = 17304",
  "mem[52991] = 17232",
  "mask = 10XX0XX0011X1110X0X10X001011X0000100",
  "mem[47449] = 215013226",
  "mem[20588] = 55592",
  "mask = X001000001110110X01XX011X10XX0100X10",
  "mem[13179] = 512319",
  "mem[45178] = 619",
  "mem[14837] = 266",
  "mem[29808] = 4353",
  "mask = 10X1X0000111X11111X101X110111X11X00X",
  "mem[55424] = 10051",
  "mem[47452] = 2089",
  "mem[19355] = 4637532",
  "mem[17193] = 4322102",
  "mem[1569] = 22208"
]

dummy_input = [
  "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
  "mem[8] = 11",
  "mem[7] = 101",
  "mem[8] = 0"
]

dummy_input2 = [
  "mask = 000000000000000000000000000000X1001X",
  "mem[42] = 100",
  "mask = 00000000000000000000000000000000X0XX",
  "mem[26] = 1"
]

p "Part 1: #{part1(input)}"
p "Part 2: #{part2(input)}"
# Save all mask values when encountered
# Convert all subsequent mem values to binary
# Do the process to and them together or something
# And save all values
# When we hit another mask, clear the mem
# When we get to the end of the program, save the last summed value
