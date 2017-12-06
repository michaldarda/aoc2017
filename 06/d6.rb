blocks = File.read('input').split(/\s+/).map(&:to_i)

def repair(blocks)
  cache = {}
  moves = 0
  while cache[blocks].nil?
    cache[blocks] = moves
    moves+=1
    max = blocks.max
    max_index = blocks.index(max)
    blocks[max_index] = 0
    i = (max_index + 1) % blocks.length
    while max > 0
      blocks[i] += 1
      i = (i + 1) % blocks.length
      max -= 1
    end
  end
  [moves, moves - cache[blocks]]
end

puts repair([0, 2, 7, 0]).inspect
puts repair(blocks).inspect
