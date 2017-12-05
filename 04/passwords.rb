count = 0
File.read('input').each_line do |line|
  splitted_line = line.split(/\s/)
  anagrammed_line = splitted_line.map(&:each_char).map(&:sort).map(&:join).uniq
  count+=1 if anagrammed_line.size == splitted_line.size
end
puts count
