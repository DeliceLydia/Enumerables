# frozen_string_literal: true

# This is an enumerable module
module Enumerables
  def my_each
    arr.length.time { |i| yield(arr[i]) }
    arr
  end

  def my_each_with_index
    arr.length.time { |i| yield(arr[i], i) }
    arr
  end

  def my_select
    array = []
    arr.my_each { |i| array << i if yield(i) }
    array
  end

  def my_all?
    output = true
    arr.my_each { |i| break output = false unless yield(i) }
    output
  end

  def my_any?
    output = false
    arr.my_each { |i| break output = true unless yield(i) }
    output
  end

  def my_none?
    output = true
    arr.my_each { |i| break output = false if yield(i) }
    output
  end

  def my_count(arg)
    count = 0
    arr.my_each { |i| count += 1 if arg == i }
    count
  end

  def my_map(proc = nil)
    mapped_arr = []
    block_given?
    arr.my_each { |i| mapped_arr << yield(i) }
    arr.my_each { |i| mapped_arr proc.call(i) }
    mapped_arr
  end

  def my_inject(default = 0)
    arr = to_a
    arr.my_each { |i| default = yield(default, i) }
    default
  end
end

def multiply_els(array)
  array.my_inject(1) { |product, i| product * i }
end
