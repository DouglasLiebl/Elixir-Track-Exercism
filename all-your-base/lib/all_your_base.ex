defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}

  @doc """
  Aqui, um bloco cond é usado para realizar verificações iniciais:

  Se a base de entrada (input_base) for menor que 2, retorna um erro indicando que a base de entrada deve ser maior ou igual a 2.
  Se a base de saída (output_base) for menor que 2, retorna um erro indicando que a base de saída deve ser maior ou igual a 2.
  Se algum dos dígitos for menor que 0 ou maior ou igual à base de entrada, retorna um erro indicando que todos os dígitos devem ser >= 0 e < base de entrada.
  Se nenhuma das condições acima for atendida, chama a função privada exec/3 para realizar a conversão.
  """
  def convert(digits, input_base, output_base) do
    cond do
      input_base < 2 -> {:error, "input base must be >= 2"}
      output_base < 2 -> {:error, "output base must be >= 2"}
      Enum.any?(digits, &(&1 < 0 or &1 >= input_base)) -> {:error, "all digits must be >= 0 and < input base"}
      true -> {:ok, exec(digits, input_base, output_base)}
    end
  end

  @doc """
  Aqui, a função privada exec/3 realiza a conversão de base:

  Inverte a lista de dígitos (digits) para facilitar os cálculos.
  Usa Enum.with_index/1 para associar cada dígito à sua posição na lista.
  Chama from_base/3 para converter a lista de dígitos para o valor em base base_a.
  Chama to_base/3 para converter o valor de base base_a para base base_b.
  """
  defp exec(digits, base_a, base_b) do
    Enum.reverse(digits)
    |> Enum.with_index()
    |> from_base(base_a, 0)
    |> to_base(base_b, [])
  end

  @doc """
  Esta função privada converte um valor da base base para uma lista de dígitos na base base. Se o valor for nil, retorna nil. Se o valor for menor que a base, adiciona o valor à lista de acumuladores acc. Caso contrário, continua a divisão do valor pelo base e acumula o resto na lista acc, repetindo até que o valor seja menor que a base.
  """
  defp to_base(nil, _, _), do: nil
  defp to_base(value, base, acc) when value < base, do: [value | acc]

  defp to_base(value, base, acc) do
    to_base(div(value, base), base, [rem(value, base) | acc])
  end

  @doc """
  Esta função privada converte uma lista de dígitos e índices associados para um valor na base base. Utiliza a fórmula matemática para converter a partir dos dígitos e índices associados, acumulando o resultado em acc. A função termina quando todos os dígitos foram processados, e o valor acumulado é truncado para um número inteiro.
  """
  defp from_base([{head, index} | tail], base, acc) do
    from_base(tail, base, acc + head * :math.pow(base, index))
  end

  defp from_base([], _base, acc), do: trunc(acc)


end
