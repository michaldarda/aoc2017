require 'prime'

$reverse_index = {}
$coordinates = {}
$inverse = {}

NUM = 25

class Point < Struct.new(:x, :y)
  def go(number, move)
    case move
    when :right then Point.new(self.x + number, self.y)
    when :up    then Point.new(self.x, self.y + number)
    when :left  then Point.new(self.x - number, self.y)
    when :down  then Point.new(self.x, self.y - number)
    end
  end

  def to_s
    "(#{self.x}, #{self.y})"
  end
end

def adjancend_sum(point)
  [
    Point.new(point.x-1, point.y-1),
    Point.new(point.x-1, point.y),
    Point.new(point.x-1, point.y+1),

    Point.new(point.x, point.y-1),
    Point.new(point.x, point.y),
    Point.new(point.x, point.y+1),

    Point.new(point.x+1, point.y-1),
    Point.new(point.x+1, point.y),
    Point.new(point.x+1, point.y+1)
  ].inject(0) do |r, point|
    if $inverse[point]
      r += $inverse[point]
    end
    r
  end
end

def spiral_grid(num)
  coords = Point.new(0, 0)
  moves_stack = []
  start = 1
  $coordinates[1] = Point.new(0,0)
  $inverse[Point.new(0,0)] = 1

  iter = 1
  while start <= num
    next_move = spriral_counting(iter)
    iter+=1

    next_move.first.times do |i|
      i = i + 1
      $coordinates[start+i] = $coordinates[start+i-1].go(1, next_move.last)
      sum = adjancend_sum($coordinates[start+i])
      raise sum.to_s if sum > 289326
      $inverse[$coordinates[start+i-1].go(1, next_move.last)] = sum
    end
    start+=next_move.first
  end
end

def spriral_counting(num)
  [$hash[num-1], %i(right up left down)[num % 4 - 1]]
end

MAX_NUM = 289326
$hash = (MAX_NUM/2).times.map do |num| [num+1, num+1] end.flatten
puts $coordinates[289326]

def manhattan_distance(from, to)
  ((from.x - to.x).abs + (from.y - to.y).abs).abs
end

def carry(from, to)
  path = []
  directions = [:left, :right, :up, :down]
  while !(from.x == to.x && from.y == to.y)
    new_direction = directions.map do |direction|
      [direction, manhattan_distance(from.go(1, direction), to)]
    end.min_by(&:last)
    path << new_direction.first
    from = from.go(1, new_direction.first)
  end
  puts path.inspect
  path
end

def coordinates(num)
  $coordinates[num]
end

spiral_grid(289326)

# puts carry(coordinates(1), coordinates(1)).size
# puts carry(coordinates(12), coordinates(1)).size
# puts carry(coordinates(23), coordinates(1)).size
# puts carry(coordinates(1024), coordinates(1)).size
# puts carry(coordinates(289326), coordinates(1)).size
