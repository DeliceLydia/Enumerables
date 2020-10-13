module Enumerables
  def my_each
    arr = to_a
    arr.length.time { |i| yield(arr[i])}
    arr
  end

  def my_each_with_index
    arr = to_a
    arr.length.time { |i| yield(arr[i], i)}
    arr
  end

  

end








