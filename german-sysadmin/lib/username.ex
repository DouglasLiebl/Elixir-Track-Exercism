defmodule Username do

  @doc """
  Enum.flat_map(&my_function/1) aplica a função my_function/1 a cada caractere do username. A função my_function/1 mapeia certos caracteres especiais para suas formas "normais" (por exemplo, substituindo ?ä por 'ae').
  Enum.filter(&allowed_char?/1) filtra os caracteres resultantes, mantendo apenas aqueles que passam na condição definida em allowed_char?/1.
  """
  def sanitize(username) do
    username
    |> Enum.flat_map(&my_function/1)
    |> Enum.filter(&allowed_char?/1)
  end

  @doc """
  Esta função auxiliar, my_function/1, mapeia caracteres específicos para suas versões normalizadas.
  Por exemplo, se o caractere for ?ä, ele será substituído por 'ae'.
  """
  defp my_function(char) do
    case char do
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      _ -> [char]
    end
  end

  @doc """
  Outra função auxiliar, allowed_char?/1, verifica se um caractere é permitido no nome de usuário.
  Neste caso, apenas caracteres de 'a' a 'z' e o caractere '_' são considerados permitidos.
  """
  defp allowed_char?(char) do
    char in ?a..?z or char == ?_
  end
end
