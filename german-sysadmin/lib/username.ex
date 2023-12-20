defmodule Username do
  def sanitize(username) do
    username
    |> Enum.flat_map(&my_function/1)
    |> Enum.filter(&allowed_char?/1)
  end

  defp my_function(char) do
    case char do
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      _ -> [char]
    end
  end

  defp allowed_char?(char) do
    char in ?a..?z or char == ?_
  end
end
