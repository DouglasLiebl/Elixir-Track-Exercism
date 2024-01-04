defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """

  @doc"""
  Define a função calc/1 que recebe um argumento input. A restrição when is_integer(input) and input > 0 garante que o argumento seja um número inteiro positivo.
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_integer(input) and input > 0 do
    do_calc(input, 0)
  end

  defp do_calc(1, steps), do: steps
  defp do_calc(input, steps) when rem(input, 2) == 0, do: do_calc(div(input, 2), steps + 1)
  defp do_calc(input, steps), do: do_calc(3 * input + 1, steps + 1)
end
