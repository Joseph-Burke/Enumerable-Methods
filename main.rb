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
      arr.my_each { |i| output_object.push(i) if yield i[0] }
      return output_object.to_h
    end
    arr.my_each { |i| output_object.push(i) if yield i }
    output_object
  end
  # --------------------
  # #MY_ALL?
  # --------------------

  def my_all?(arg = nil)
    arr = to_a
    if arg.is_a?(Regexp)
      arr.my_each { |i| return false unless i.match(arg) }
      return true
    end
    unless block_given?
      arr.my_each { |i| return false unless i } if arg.nil?
      arr.my_each { |i| return false unless arg == i } unless arg.nil?
    end
    arr.my_each { |i| return false unless yield i } if block_given?
    true
  end
  # --------------------
  # #MY_ANY?
  # --------------------

  def my_any?
    arr = to_a
    unless block_given?
      arr.my_each { |i| return true if i }
      return false
    end
    if is_a?(Hash)
      arr.my_each { |i| return true if yield i }
      return false
    end
    arr.my_each { |i| return true if yield i }
    false
  end
  # --------------------
  # #MY_NONE?
  # --------------------

  def my_none?
    arr = to_a
    unless block_given?
      arr.my_each { |i| return false if i }
      return true
    end
    if is_a?(Hash)
      arr.my_each { |i| return false if yield i }
      return true
    end
    arr.my_each { |i| return false if yield i }
    true
  end
  # --------------------
  # #MY_COUNT
  # --------------------

  def my_count(argument = nil)
    count = 0
    arr = to_a

    if argument.nil?
      block_given? ? arr.my_each { |i| count += 1 if yield i } : arr.my_each { count += 1 }
    elsif !block_given?
      arr.my_each { |i| count += 1 if i == argument }
    end
    count
  end
  # --------------------
  # #MY_MAP
  # --------------------

  def my_map(&_proc)
    arr = to_a
    output_array = []
    arr.my_each { |i| output_array.push(yield i) }
    output_array
  end
  # --------------------
  # #MY_INJECT
  # --------------------

  def my_inject(*args)
    arr = to_a
    arg1 = args[0]
    arg2 = args[1]

    both_args = arg1 && arg2
    only_first = arg1 && !arg2
    no_arg = !arg1

    memo = (only_first && !block_given?) || (no_arg && block_given?) ? arr[0] : arg1

    if block_given?
      arr.drop(1).my_each { |i| memo = yield memo, i } if no_arg
      arr.my_each { |i| memo = yield memo, i } if only_first
    else
      arr.drop(1).my_each { |i| memo = memo.send(arg1, i) } if only_first
      arr.my_each { |i| memo = memo.send(arg2, i) } if both_args
    end
    memo
  end
end

# --------------------
# #MULTIPLY_ELS
# --------------------

def multiply_els(array)
  array.my_inject(:*)
end

# TESTS ------------------------

test_array = [2, 1, 6, 7, 4, 8, 10]
test_hash = {
  key1: 'value_1',
  key2: 'value_2'
}
test_range = (1..10)
test_integer = 5
test_string = "STRING"
test_proc = Proc.new {|element| element + ", nice to meet you."}

# p test_hash
# p test_array.all?(3)
# p test_array.my_all?(3)

# 2. my_all?:
# [2, 1, 6, 7, 4, 8, 10].my_all?(3) # => false
# p %w[Marc Luc Jean].my_all?('Jean') # => false
p %w[Marc Jean].my_all?(/a/) # => false
p %w[Marc Jean].all?(/a/) # => false

# p "hello".match?(/e/)

# p /e/.is_a?(Regexp)



# arr.each {|i| return false unless i.match(arg1)} if arg.is_a?(Regexp)

# Detect if the argument is a regexp and give it certain behaviour

