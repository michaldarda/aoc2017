class Grid
  def initialize
    @mat = { 0 => {0 => 1 } }
  end

  def []=(coords, value)
    @mat[coords.y] ||= {}
    @mat[coords.y][coords.x] = value
  end

  def size
    Point.new(@mat[0].length, @mat.length)
  end

  def to_s
    s = String.new
    @mat.sort.to_h.each do |_, values |
      s << values.sort.to_h.values.inspect
      s << "\n"
    end
    s
  end
end

$grid = Grid.new

class Point < Struct.new(:x, :y)
  def go(direction)
    case direction
    when :right then self.x += $grid.size.x
    when :up    then self.y += $grid.size.y
    when :left  then self.x -= $grid.size.x
    when :down  then self.y -= $grid.size.y
    end
  end
end

def spiral_grid(num)
  coords = Point.new(0, 0)
  (2..10).each_with_index do |current_number, move|
    next_move = spriral_counting(move)
    coords.go(next_move)
    $grid[coords] = current_number
  end
  $grid
end

def go(coordinates, direction)
  case direction
  when :right
    Point.new(coordinates.x + 1, coordinates.y)
  when :up
    Point.new(coordinates.x, coordinates.y + 1)
  when :left
    Point.new(coordinates.x - 1, coordinates.y)
  when :down
    Point.new(coordinates.x, coordinates.y - 1)
  end
end

def spriral_counting(num)
  index = num % 4
  index = 4 if index == 0
  %i(right up left down)[index - 1]
end

puts spiral_grid(1024).to_s
