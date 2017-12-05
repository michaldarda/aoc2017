defmodule Maze do
  def jump(list, variant \\ 2) do
    case variant do
      2 -> jump(list, 0, 0, fn(v) -> if (v) >= 3, do: v - 1, else: v + 1 end)
      _ -> jump(list, 0, 0, fn(v) -> v + 1 end)
    end
  end

  defp jump(tuple, jump, moves, transformation) do
    if jump >= tuple_size(tuple) do
      moves
    else
      old_value = elem(tuple, jump)
      new_value = transformation.(old_value)
      new_tuple = put_elem(tuple, jump, new_value)
      jump(new_tuple, jump + old_value, moves + 1, transformation)
    end
  end
end

ExUnit.start()
defmodule Tests do
  use ExUnit.Case
  test "jumps" do
    assert Maze.jump({0, 3,  0, 1, -3}, 1) == 5
    assert Maze.jump({0, 3,  0, 1, -3}) == 10
  end
end

File.read!('input')
|> String.trim
|> String.split("\n")
|> Enum.map(&String.to_integer/1)
|> List.to_tuple
|> Maze.jump
|> IO.puts
