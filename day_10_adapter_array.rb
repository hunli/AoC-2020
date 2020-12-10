input = [149,
87,
67,
45,
76,
29,
107,
88,
4,
11,
118,
160,
20,
115,
130,
91,
144,
152,
33,
94,
53,
148,
138,
47,
104,
121,
112,
116,
99,
105,
34,
14,
44,
137,
52,
2,
65,
141,
140,
86,
84,
81,
124,
62,
15,
68,
147,
27,
106,
28,
69,
163,
97,
111,
162,
17,
159,
122,
156,
127,
46,
35,
128,
123,
48,
38,
129,
161,
3,
24,
60,
58,
155,
22,
55,
75,
16,
8,
78,
134,
30,
61,
72,
54,
41,
1,
59,
101,
10,
85,
139,
9,
98,
21,
108,
117,
131,
66,
23,
77,
7,
100,
51,]

dummy_input = [
  16,
  10,
  15,
  5,
  1,
  11,
  7,
  19,
  6,
  12,
  4,
]

dummy_input2 = [
  28,
  33,
  18,
  42,
  31,
  14,
  46,
  20,
  48,
  47,
  24,
  23,
  49,
  45,
  19,
  38,
  39,
  11,
  1,
  32,
  25,
  35,
  8,
  17,
  7,
  9,
  4,
  2,
  34,
  10,
  3,
]

def product_of_1_v_3_jolt_differences(input)
  current_jolt = 0
  sorted_input = input.sort
  one_jolt_count = 0
  three_jolt_count = 1

  sorted_input.each do |jolt|
    if jolt - current_jolt == 1
      one_jolt_count += 1
    elsif jolt - current_jolt == 3
      three_jolt_count += 1
    elsif jolt - current_jolt > 3
      raise "Error with jolt difference : #{jolt} and #{current_jolt}"
    end

    current_jolt = jolt
  end

  one_jolt_count * three_jolt_count
end

def combination_of_adapters(input, start_index = 0, current_jolt = 0, memoized = {})
  return 1 if start_index >= input.length
  return memoized[start_index] if memoized[start_index]

  memoized[start_index] = 0

  (start_index...input.length).each do |index|
    break if input[index] - current_jolt > 3
    memoized[start_index] += memoized[index + 1] || combination_of_adapters(input, index + 1, input[index], memoized)
  end

  memoized[start_index]
end

p "Product of 1 jolt and 3 jolt differences: #{product_of_1_v_3_jolt_differences(input)}"
p "Combinations of adapters: #{combination_of_adapters(input.sort)}"
