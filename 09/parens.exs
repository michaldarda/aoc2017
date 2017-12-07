defmodule Parens do
  def count_groups(char_list) do
    count_groups(char_list, [], 0, 0)
  end

  def count_groups(char_list, stack, groups_count, group_score) do
    case char_list do
      [] -> groups_count
      [current_char | rest_of_the_chars] ->
        [stack_head | stack_tail] = destruct(stack)
        case [stack_head, current_char] do
          # garbage and ignoring
          ["!", _] -> count_groups(rest_of_the_chars, stack_tail, groups_count, group_score)
          [_, "!"] -> count_groups(rest_of_the_chars, [current_char | stack], groups_count, group_score)

          [_, ">"] -> count_groups(rest_of_the_chars, stack_tail, groups_count, group_score)
          ["<", _] ->
            IO.puts 'garbage' # so I can then grep garbage | wc xD
            count_groups(rest_of_the_chars, stack, groups_count, group_score)
          [_, "<"] -> count_groups(rest_of_the_chars, [current_char | stack], groups_count, group_score)

          [_, "{"] -> count_groups(rest_of_the_chars, [current_char | stack], groups_count, group_score + 1)
          [_, "}"] -> count_groups(rest_of_the_chars, stack_tail, groups_count + group_score, group_score - 1)

          [_, _] -> count_groups(rest_of_the_chars, stack, groups_count, group_score)
        end
    end
  end

  def destruct([]) do
    [nil]
  end

  def destruct(a) do
    a
  end
end

ExUnit.start()
defmodule Tests do
  use ExUnit.Case
  test "counts groups in input string" do
    assert Parens.count_groups("{}" |> String.graphemes) == 1
    assert Parens.count_groups("{{{}}}" |> String.graphemes) == 6
    assert Parens.count_groups("{{},{}}" |> String.graphemes) == 5
    assert Parens.count_groups("{{{},{},{{}}}}" |> String.graphemes) == 16
    assert Parens.count_groups("{<a>,<a>,<a>,<a>}" |> String.graphemes) == 1
    assert Parens.count_groups("{{<ab>},{<ab>},{<ab>},{<ab>}}" |> String.graphemes) == 9
    assert Parens.count_groups("{{<!!>},{<!!>},{<!!>},{<!!>}}" |> String.graphemes) == 9
    assert Parens.count_groups("{{<a!>},{<a!>},{<a!>},{<ab>}}" |> String.graphemes) == 3
  end
end

File.read!('input')
|> String.graphemes
|> Parens.count_groups
|> IO.puts
