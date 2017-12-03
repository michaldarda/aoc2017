input = File.read("input")

ar = input.each_char.map { |c| Integer(c) rescue nil }.compact

def circular_list(array, ind)
  elem = array[ind]
  return elem if elem

  array[ind - array.length]
end

def puzzle(input)
  sum = 0
  input.each_with_index do |elem, i|
    matching_elem = circular_list(input, i + input.length / 2)
    if elem == matching_elem
      sum += elem
    end
  end
  sum
end

puts puzzle(ar)

puts puzzle([1,1,2,2])
puts puzzle([1,1,1,1])
