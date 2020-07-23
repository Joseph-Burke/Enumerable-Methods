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
      arr.length.times do |i|
        if (yield arr[i][0])
          output_object.push(arr[i])
        end
      end
      return output_object.to_h
    end
    arr.length.times do |i|
      if (yield arr[i])
        output_object.push(self.to_a[i])
      end
    end
    output_object
  end
  # --------------------
  # #MY_ALL?
  # --------------------
  def my_all?(args=nil)
    arr = to_a
    unless block_given?
      arr.length.times {|i| return false unless arr[i]}
        return true
    end

    if is_a?(Hash)
      arr.length.times do |i|
        return false unless yield arr[i]
      end
      return true
    end

    arr.length.times do |i|
      unless (yield arr[i])
        return false
      end
    end
    true
  end
  # --------------------
  # #MY_ANY?
  # --------------------
  def my_any?
    arr = to_a
    unless block_given?
      arr.length.times {|i| return true if arr[i]}
        return false
    end

    if is_a?(Hash)
      arr.length.times do |i|
        return true if yield arr[i]
      end
      return false
    end

    arr.length.times do |i|
      return true if yield arr[i]
    end
    return false
  end
  # --------------------
  # #MY_NONE?
  # --------------------
  def my_none?
    self.length.times do |i|
      if (yield self[i])
        return false
      end
    end
    return true
  end
  # --------------------
  # #MY_COUNT
  # --------------------
  def my_count(argument=nil)
    count = 0
    if argument.nil? && !block_given?
      self.length.times do |i|
        count += 1
      end
    elsif !argument.nil? && !block_given?
      self.length.times do |i|
        if self[i] == argument
          count += 1
        end
      end
    elsif argument.nil? && block_given?
      self.length.times do |i|
        if (yield self[i])
          count += 1
        end
      end
    end
    count
  end
  # --------------------
  # #MY_MAP
  # --------------------
  def my_map
    output_array = []
     self.length.times do |i|
       output_array.push(yield self[i])
     end
    output_array
  end
  # --------------------
  # #MY_INJECT
  # --------------------
  def my_inject(arg1=nil, arg2=nil)
      memo = 0
      if arg2.nil? && !block_given?
        # 1. If there is one argument and no block, the argument represents
        # a symbol.
        for i in 1..self.length-1 do
          memo = memo.send(arg1, self[i])
        end
        # 2. 2 arguments. arg1 is initial, arg2 is symbol of operator.
      elsif !arg1.nil? && !arg2.nil?
        memo = arg1
        self.length.times do |i|
          memo = memo.send(arg2, self[i])
        end
      elsif !arg1.nil? && arg2.nil? && block_given?
        # 3. Block, one argument representing initial value.
        memo = arg1
        self.length.times do |i|
          memo = yield memo, self[i]
        end
      elsif arg1.nil? && arg2.nil? && block_given?
        self.length.times do |i|
          memo = yield memo, self[i]
        end
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
test_array = [1, 2, 3, 4, 5, "string"]
test_hash = {
  :key1 => "value_1",
  :key2 => "value_2",
  :key3 => "value_3"
}
test_range = (0..10)
test_integer = 5
test_string = "STRING"

# #MY_EACH

# #MY_EACH_WITH_INDEX

# p test_array.each {|e, i| puts "#{e}. #{i}."}
# puts
# p test_array.my_each {|e, i| puts "#{e}. #{i}."}

# #MY_SELECT
# p test_string.select {|element| element.even?}
# p test_string.my_select {|element| element.even?}

# #MY_ALL?

# p test_string.all? {|element| element.is_a?(Integer)}
# p test_string.my_all? {|element| element.is_a?(Integer)}


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

# #MY_ANY?

# p test_string.any? {|element| p element.is_a?(Integer)}
puts
# p test_string.my_any? {|element| p element.is_a?(Integer)}


# #MY_NONE?

# #MY_COUNT

# #MY_MAP

# #MY_INJECT
