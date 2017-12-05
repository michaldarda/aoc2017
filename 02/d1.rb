def line_divisors(ary)
  line_sum = 0
  ary.each_with_index do |num, i|
    ary.each_with_index do |other_num, j|
      if j != i && (num % other_num == 0)
        line_sum += (num / other_num)
      end
    end
  end
  line_sum
end

def zadanko(mat)
  sum = 0
  mat.each do |row|
    sum += line_divisors(row)
  end
  sum
end

puts zadanko(File.read('input').each_line.map { |l| l.split("\t").map(&:to_i) })
puts zadanko([[5, 9, 2, 8],
              [9, 4, 7, 3],
              [3, 8, 6, 5]])
