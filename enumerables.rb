module Enumerables
  def my_each
    arr = to_a
    arr.length.time { |i| yield(arr[i]) }
    arr
  end

  def my_each_with_index
    arr = to_a
    arr.length.time { |i| yield(arr[i], i) }
    arr
  end

  def my_select
    arr = to_a
    filtered_arr = []
    arr.my_each do |i|
      result.push(i) if yield i
    end
    filtered_arr
  end
end

def my_all(default = nil)
  arr = to_a
  if default == Numeric
    arr.my_each do |i|
      return false unless i.class == Integer || i.class == Float || i.class == Complex
    end
    true
  elsif block_given?
    arr.my_each do |i|
      return false unless yield i
    end
    true
  elsif !block_given? && !default
    arr.my_each do |i|
      return false unless i
    end
    true
  end

  def my_any?(default = nil)
    arr = to_a
    if default == Numeric
      arr.my_each do |i|
        return true unless i.class == Integer || i.class == Float || i.class == Complex
      end
      false
    elsif block_given?
      arr.my_each do |i|
        return true unless yield i
      end
      false
    elsif !block_given? && !default
      arr.my_each do |i|
        return true unless i
      end
      false
    end
  end

  def my_none?(default = nil)
    arr = to_a
    if default == Numeric
      arr.my_each do |i|
        return true unless i.class == Integer || i.class == Float || i.class == Complex
      end
      false
    elsif block_given?
      arr.my_each do |i|
        return false unless yield i
      end
      true
    elsif !block_given? && !default
      arr.my_each do |i|
        return false unless i
      end
      true
    end
  end

  def my_count(default = nil)
    arr = to_a
    count = 0
    if default
      arr.my_each do |i|
        count += 1 if i == default
  end
  elsif block_given?
    arr.my_each do |i|
      count += 1 if (yield i) == true
    end
  else
    arr.my_each do
      count += 1
    end
  end
  count
end

  def my_map(default = nil)
    arr = to_a
    mapped_arr = []
    if default == nil
      arr.my_each do |i| mapped_arr.push(yield(i))
      end
      mapped_arr
    else
      arr.my_each do |i| mapped_arr.push default.call(i)
      end
      mapped_arr
  end
end
  
end
