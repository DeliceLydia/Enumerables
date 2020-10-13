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
end
