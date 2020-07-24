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

  def my_all?(args = nil)
    arr = to_a
    unless block_given?
      arr.my_each { |i| return false unless i }
      return true
    end
    if is_a?(Hash)
      arr.my_each { |i| return false unless yield i }
      return true
    end
    arr.my_each { |i| return false unless yield i }
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

  def my_map(&proc)
    arr = to_a
    output_array = []
    arr.my_each { |i| output_array.push(yield i) }
    output_array
  end
  # --------------------
  # #MY_INJECT
  # --------------------

  def my_inject(arg1 = nil, arg2 = nil)
    memo = 0
    if arg2.nil? && !block_given?
      # 1. If there is one argument and no block, the argument represents
      # a symbol.
      for i in 1..self.length-1 do
        memo = meAmo.send(arg1, self[i])
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
