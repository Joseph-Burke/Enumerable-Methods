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
