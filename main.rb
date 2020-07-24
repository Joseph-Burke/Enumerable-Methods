module Enumerable
  # --------------------
  # #MY_EACH
  # --------------------
  def my_each
    return to_enum unless block_given?
    arr = to_a
    arr.length.times do |i|
      yield arr[i]
    end
    self
  end
  # --------------------
  # #MY_EACH_WITH_INDEX
  # --------------------
  def my_each_with_index
    return to_enum(:each_with_index) unless block_given?
    arr = to_a
    arr.length.times do |i|
      yield arr[i], i
    end
    self
  end
  # --------------------
  # #MY_SELECT
  # --------------------
  def my_select
    return to_enum(:select) unless block_given?
    output_object = []
    arr = to_a
    if is_a?(Hash)
      arr.my_each {|i| output_object.push(i) if (yield i[0])}
      return output_object.to_h
    end
    arr.my_each {|i| output_object.push(i) if (yield i)}
    output_object
  end
  # --------------------
  # #MY_ALL?
  # --------------------
  def my_all?(args=nil)
    arr = to_a
    unless block_given?
      arr.my_each {|i| return false unless i}
      return true
    end
    if is_a?(Hash)
      arr.my_each {|i| return false unless (yield i)}
      return true
    end
    arr.my_each {|i| return false unless (yield i)}
    true
  end
  # --------------------
  # #MY_ANY?
  # --------------------
  def my_any?
    arr = to_a
    unless block_given?
      arr.my_each {|i| return true if i}
        return false
    end
    if is_a?(Hash)
      arr.my_each {|i| return true if (yield i)}
      return false
    end
    arr.my_each {|i| return true if (yield i)}
    return false
  end
  # --------------------
  # #MY_NONE?
  # --------------------
  def my_none?
    arr = to_a
    unless block_given?
      arr.my_each {|i| return false if i}
      return true
    end
    if is_a?(Hash)
      arr.my_each {|i| return false if (yield i)}
      return true
    end
    arr.my_each {|i| return false if (yield i)}
    true
  end
  # --------------------
  # #MY_COUNT
  # --------------------
  def my_count(argument=nil)
    count = 0
    arr = to_a
    if argument.nil? && !block_given?
      arr.my_each {|i| count += 1}
    elsif !argument.nil? && !block_given?
      arr.my_each {|i| count += 1 if i == argument}
    elsif argument.nil? && block_given?
      arr.my_each {|i| count += 1 if (yield i)}
    end
    count
  end
  # --------------------
  # #MY_MAP
  # --------------------
  def my_map(&proc)
    arr = to_a
    output_array = []
    arr.my_each {|i| output_array.push(yield i)}
    output_array
  end
  # --------------------
  # #MY_INJECT
  # --------------------
  def my_inject(arg1=nil, arg2=nil)
      arr = to_a
      if arg2.nil? && !block_given?
        memo = arr[0]
        arr[1..-1].each {|i| memo = memo.send(arg1, i)}
      elsif !arg1.nil? && !arg2.nil?
        memo = arg1
        arr.each {|i| memo = memo.send(arg2, i)}
      elsif !arg1.nil? && arg2.nil? && block_given?
        memo = arg1
        arr.each {|i| memo = yield memo, i}
      elsif arg1.nil? && arg2.nil? && block_given?
        memo = arr[0]
        arr[1..-1].each {|i| memo = yield memo, i}
      end
      memo
    end
  # --------------------
  # #MULTIPLY_ELS
  # --------------------
  def multiply_els(array)
    array.my_inject(:*)
  end
end

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

# p test_array.map(&test_proc)
# p test_array.my_map(&test_proc)

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
