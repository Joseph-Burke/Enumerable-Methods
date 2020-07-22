module Enumerable
  # --------------------
  # #MY_EACH
  # --------------------
  def my_each
    self.length.times do |i|
      yield self[i]
    end
    self
  end
  # --------------------
  # #MY_EACH_WITH_INDEX
  # --------------------
  def my_each_with_index
    self.length.times do |i|
      yield self[i], i
    end
    self
  end
  # --------------------
  # #MY_SELECT
  # --------------------
  def my_select
    new_array = []
    self.length.times do |i|
      if (yield self[i])
        new_array.push(self[i])
      end
    end
    new_array
  end
  # --------------------
  # #MY_ALL?
  # --------------------
  def my_all?
    self.length.times do |i|
      if !(yield self[i])
        return false
      end
    end
    return true
  end
  # --------------------
  # #MY_ANY?
  # --------------------
  def my_any?
    self.length.times do |i|
      if (yield self[i])
        return true
      end
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
end

# TESTS ---------------------------

# #MY_EACH

# #MY_EACH_WITH_INDEX

# #MY_SELECT

# #MY_ALL?

# #MY_ANY?

# #MY_NONE?

# #MY_COUNT

# #MY_MAP

# #MY_INJECT
