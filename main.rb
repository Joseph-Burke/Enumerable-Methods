module Enumerable
  # --------------------
  # #MY_EACH
  # --------------------

  # --------------------
  # #MY_EACH_WITH_INDEX
  # --------------------

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

  # --------------------
  # #MY_MAP
  # --------------------

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
