defmodule InputParser do
  def parse(input) do
    String.graphemes(input)
    require IEx; IEx.pry
  end
end

defmodule CaptchaSolver do
  def solve(array) do
    Enum.filter(array, fn x -> )
  end
end

System.argv
|> hd
|> File.read!
|> InputParser.parse
|> IO.puts
