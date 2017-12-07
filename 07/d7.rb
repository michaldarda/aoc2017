require 'pp'
io = File.read('input').each_line.reduce({}) do |r, line|
  match = line.match(/(?<core>.*)\s+\((?<weight>.*)\)(\s->\s)?(?<next>.*)/)
  r[match[:core]] = { weight: match[:weight].to_i, next: match[:next].split(", ") }
  r
end

io.sort_by { |(k, v)| v[:next].length }.reverse.each do |(k, v)|
  v[:next] = v[:next].reduce({}) { |acc, ref| acc[ref] = io.delete(ref); acc }
end

def weight_cal(node)
  if node[:next].empty?
    node[:child_weight] = 0
  else
    node[:child_weight] = node[:next].reduce(0) { |acc, (_, v)| acc + v[:weight] + weight_cal(v) }
  end
end

def check(root)
  if root[:next].map { |_, v| v[:weight] + v[:child_weight] }.uniq.length != 1
    values = root[:next].map { |_, v| [v[:weight] + v[:child_weight], v] }.each_with_object(Hash.new) { |(occur, v),counts| counts[occur] = v }
    occures = root[:next].map { |_, v| v[:weight] + v[:child_weight] }.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
    wrong = values[occures.find { |(k, v)| v == 1 }.first]
    pp
    pp wrong
    pp
    check(wrong)
  else
    root[:next].sort_by{ |(_, v)| v[:weight] }.each do |(k, v)| check(v) end
  end
end
pp io
pp weight_cal(io.values.first)
pp io
pp check(io.values.first)
