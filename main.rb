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

  def my_any?(arg = nil)
    arr = to_a
    has_argument = !arg.nil?
    if has_argument
      arr.my_each { |i| return true if i.match(arg) } if arg.is_a?(Regexp)
      arr.my_each { |i| return true if i.is_a?(arg) } if arg.is_a?(Class || Module)
      arr.my_each { |i| return true if arg == i } unless arg.is_a?(Regexp || Class || Module)
    else
      arr.my_each { |i| return true if i } unless block_given?
      arr.my_each { |i| return true if yield i } if block_given?
    end
    false
  end
  # --------------------
  # #MY_NONE?
  # --------------------

  def my_none?(arg = nil)
    arr = to_a
    has_argument = !arg.nil?
    if has_argument
      arr.my_each { |i| return false if i.match(arg) } if arg.is_a?(Regexp)
      arr.my_each { |i| return false if i.is_a?(arg) } if arg.is_a?(Class || Module)
      arr.my_each { |i| return false if arg == i } unless arg.is_a?(Regexp || Class || Module)
    else
      arr.my_each { |i| return false if i } unless block_given?
      arr.my_each { |i| return false if yield i } if block_given?
    end
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
