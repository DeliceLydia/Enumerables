module Enumerable
  def return_array(elements)
    if self.class == Range
      self
    else
      elements
    end
  end

  def my_each
    return to_enum unless block_given?

    elements = to_a
    elements.length.times do |i|
      yield(elements[i])
    end
    return_array(elements)
  end

  def my_each_with_index
    return to_enum unless block_given?

    elements = to_a
    elements.length.times do |i|
      yield(elements[i], i)
    end
    return_array(elements)
  end

  def my_select
    return to_enum unless block_given?

    elements = to_a
    array = []
    elements.my_each do |i|
      array.push(i) if yield(i)
    end
    array
  end

  def my_all?
    output = true
    my_each { |i| break output = false unless yield(i) }
    output
  end

  def my_any?
    output = false
    my_each { |i| break output = true unless yield(i) }
    output
  end

  def my_none?
    output = true
    my_each { |i| break output = false if yield(i) }
    output
  end

  def my_count(arg)
    count = 0
    my_each { |i| count += 1 if arg == i }
    count
  end

  def my_map(proc = nil)
    mapped_arr = []
    block_given?
    my_each { |i| mapped_arr << yield(i) }
    my_each { |i| mapped_arr proc.call(i) }
    mapped_arr
  end

  def my_inject(default = 0)
    my_each { |i| default = yield(default, i) }
    default
  end
end

def multiply_els(array)
  array.my_inject(1) { |product, i| product * i }
end

# test = [4, 5, 6]
# result = []
# test1 = test.my_select{|x| puts result.push(x >4) }
