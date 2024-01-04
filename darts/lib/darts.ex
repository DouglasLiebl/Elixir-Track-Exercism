defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    @doc"""
    Calcula a distância euclidiana entre o ponto representado por {x, y} e a origem (0, 0) usando a fórmula da distância euclidiana. Isso é feito elevando ao quadrado as coordenadas x e y, somando esses quadrados e, em seguida, tirando a raiz quadrada do resultado.
    """
    distance = (:math.pow(x, 2) + :math.pow(y, 2)) |> :math.pow(0.5)

    cond do
      distance > 10 -> 0
      distance > 5 -> 1
      distance > 1 -> 5
      true -> 10
    end
  end
end
