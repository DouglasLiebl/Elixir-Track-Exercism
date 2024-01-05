defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count(~c"AATAA", ?A)
  4

  iex> NucleotideCount.count(~c"AATAA", ?T)
  1
  """

  @doc"""
  Esta é a definição da função count/2. A função verifica se o nucleotide está presente na lista @nucleotides. Se estiver, ela utiliza a função histogram/1 para obter um histograma da strand e retorna o valor correspondente ao nucleotide no histograma. Caso contrário, retorna 0.
  """
  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) when nucleotide in @nucleotides do
    histogram(strand)[nucleotide]
  end
  def count(_, _), do: 0

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram(~c"AATAA")
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @doc"""
  Aqui, a função histogram/1 é definida. Ela utiliza a função Enum.reduce/3 para percorrer cada caractere na strand e construir um histograma contando a ocorrência de cada nucleotídeo (A, T, C, G) na strand. O resultado é um mapa com as contagens.
  """
  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    Enum.reduce(strand, %{?A => 0, ?T => 0, ?C => 0, ?G => 0}, fn n, acc ->
      Map.update(acc, n, 1, &(&1 + 1))
    end)
  end
end
