# TESTS ---------------------------
test_array = %w[hello hello hello hello]
test_hash = {
  :key1 => "value_1",
  :key2 => "value_2",
  :key3 => "value_3"
}
test_range = (1..10)
test_integer = 5
test_string = "STRING"
test_proc = Proc.new {|element| element + ", nice to meet you."}

# #MY_EACH

# p test_array.each {|e| puts "#{e}."}
# puts
# p test_array.my_each {|e| puts "#{e}."}

# #MY_EACH_WITH_INDEX

# p test_array.each_with_index {|e, i| puts "#{e}. #{i}."}
# puts
# p test_array.my_each_with_index {|e, i| puts "#{e}. #{i}."}

# #MY_SELECT
# p test_hash.select {|element| p element.length > 4}
# p test_hash.my_select {|element| p element.length > 4}

# #MY_ALL?

# p test_hash.all? {|element| element.is_a?(Array)}
# p test_hash.my_all? {|element| element.is_a?(Array)}

# #MY_ANY?

# p test_array.any? {|element| element.is_a?(Integer)}
# p test_array.my_any? {|element| element.is_a?(Integer)}

# #MY_NONE?

# p test_array.none? {|element| element[0].is_a?(String)}
# p test_array.my_none? {|element| element[0].is_a?(String)}

# #MY_COUNT

# p test_array.count {|element| element.is_a?(String)}
# p test_array.my_count {|element| element.is_a?(String)}

# #MY_MAP

p test_array.map(&test_proc)
p test_array.my_map(&test_proc)

# #MY_INJECT

# 1. inject(sym) → obj WORKING
# p test_array.inject(:+)
# p test_array.my_inject(:+)

# # 2. inject(initial, sym) → obj WORKING
# p test_range.inject(-100, :+)
# p test_range.my_inject(-100, :+)

# 3. inject(initial) { |memo, obj| block } → obj WORKING
# p test_range.inject(100) {|sum, element| sum * element}
# p test_range.my_inject(100) {|sum, element| sum * element}

# 4. inject { |memo, obj| block } → obj WORKING
# p test_range.inject {|sum, element| sum + element}
# p test_range.my_inject {|sum, element| sum + element}

=begin
WE KNOW OUR METHOD HAS THE SAME BEHAVIOUR AS THE ORIGINAL FOR THE FOLLOWING CASES:
1a. WITHOUT ARGUMENT, WITHOUT CODE BLOCK.
1b. WITH ARGUMENT, WITHOUT CODE BLOCK
2. USING THE METHOD FROM AN ARRAY.
3. USING THE METHOD FROM A HASH.
4. USING THE METHOD FROM A RANGE.
5. USING THE METHOD FROM AN INTEGER.
6. USING THE METHOD FROM A STRING.
=end

# #MY_INJECT

# 1. inject(sym) → obj WORKING
# p test_array.inject(:+)
# p test_array.my_inject(:+)

# 2. inject(initial, sym) → obj WORKING
# p test_range.inject(-100, :+)
# p test_range.my_inject(-100, :+)

# 3. inject(initial) { |memo, obj| block } → obj WORKING
# p test_range.inject(100) {|sum, element| sum * element}
# p test_range.my_inject(100) {|sum, element| sum * element}

# 4. inject { |memo, obj| block } → obj WORKING
# p test_range.inject {|sum, element| sum + element}
# p test_range.my_inject {|sum, element| sum + element}
