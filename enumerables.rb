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

  def my_all?(x = nil)
    elements = to_a
    if x == Numeric
      elements.my_each do |i|
        return false unless i.class == Integer || i.class == Float || i.Complex
      end
      true
    elsif x.class == Class
      elements.my_each do |i|
        return false unless i.class == x
      end
      true
    elsif x.class == Regexp
      elements.my_each do |i|
        return false unless i =~ x
      end
      true
    elsif block_given?
      elements.my_each do |i|
        return false unless yield i
      end
      true
    elsif !block_given? && !x
      elements.my_each do |i|
        return false unless i
      end
      true
    elsif x.class != Regexp && x.class != Class
      elements.my_each do |i|
        return false unless i == x
      end
      true
    end
  end

  def my_any?
    return to_enum
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
