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

  def my_all?(default = nil)
    elements = to_a
    if default == Numeric
      elements.my_each do |i|
        return false unless i.class == Integer || i.class == Float || i.Complex
      end
      true
    elsif default.class == Class
      elements.my_each do |i|
        return false unless i.class == default
      end
      true
    elsif default.class == Regexp
      elements.my_each do |i|
        return false unless i =~ default
      end
      true
    elsif block_given?
      elements.my_each do |i|
        return false unless yield i
      end
      true
    elsif !block_given? && !default
      elements.my_each do |i|
        return false unless i
      end
      true
    elsif default.class != Regexp && default.class != Class
      elements.my_each do |i|
        return false unless i == default
      end
      true
    end
  end

  def my_any?(default = nil)
    elements = to_a
    if default == Numeric
      elements.my_each do |i|
        return true if i.class == Integer || i.class == Float || i.Complex
      end
      false
    elsif default.class == Class
      elements.my_each do |i|
        return true if i.class == default
      end
      false
    elsif default.class == Regexp
      elements.my_each do |i|
        return true if i =~ default
      end
      false
    elsif block_given?
      elements.my_each do |i|
        return true if yield i
      end
      false
    elsif !block_given? && !default
      elements.my_each do |i|
        return true if i
      end
      false
    elsif default.class != Regexp && default.class != Class
      elements.my_each do |i|
        return true if i == default
      end
      false
    end
  end

  def my_none?(default = nil)
    elements = to_a
    if default == Numeric
      elements.my_each do |i|
        return true unless i.class == Integer || i.class == Float || i.Complex
      end
      false
    elsif default.class == Class
      elements.my_each do |i|
        return false if i.class == default
      end
      true
    elsif default.class == Regexp
      elements.my_each do |i|
        return false if i =~ default
      end
      true
    elsif block_given?
      elements.my_each do |i|
        return false if yield i
      end
      true
    elsif !block_given? && !default
      elements.my_each do |i|
        return false if i
      end
      true
    elsif default.class != Regexp && default.class != Class
      elements.my_each do |i|
        return false if i == default
      end
      true
    end
  end

  def my_count(default = nil)
    elements = to_a
    count = 0
    if default
      elements.my_each do |i|
        count += 1 if i == default
      end
    elsif block_given?
      elements.my_each do |i|
        count += 1 if (yield i) == true
      end
    else
      elements.my_each do
        count += 1
      end
    end
    count
  end

  def my_map
    return to_enum unless block_given?

    mapped_arr = []
    my_each { |i| mapped_arr << yield(i) }
    mapped_arr
  end

  def my_inject(memo = self[0])
    my_each_with_index do |value, index|
      memo = yield(memo, value) if index > 0
    end
    memo
  end
end

def multiply_els(array)
  array.my_inject { |product, i| product * i }
end

result = multiply_els([2, 4, 5])
puts result
