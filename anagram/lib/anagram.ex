defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """

  @doc """
  A função match/2 recebe uma string base (base) e uma lista de candidatos (candidates). Utilizando Enum.filter/2, ela retorna uma nova lista contendo apenas os candidatos que são anagramas da string base. A comparação é feita após converter tanto a base quanto os candidatos para minúsculas, utilizando String.downcase/1, para garantir uma comparação sem distinção entre maiúsculas e minúsculas.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, fn candidate ->
      base
      |> String.downcase()
      |> anagram?(String.downcase(candidate))
    end)
  end

  @doc """
  Esta função verifica se duas palavras (word e word2) são anagramas uma da outra. A primeira cláusula trata o caso em que ambas as palavras são iguais, considerando-as como não sendo anagramas. A segunda cláusula converte ambas as palavras para uma forma ordenada de seus codepoints usando a função sort_codepoints/1 e, em seguida, compara se as versões ordenadas são iguais.
  """
  defp anagram?(word, word), do: false
  defp anagram?(word, word2) do
    word = sort_codepoints(word)
    word2 = sort_codepoints(word2)

    word == word2
  end

  @doc """
  Esta função privada sort_codepoints/1 recebe uma palavra (word), converte-a em uma lista de seus codepoints usando String.codepoints/1, e, em seguida, ordena essa lista usando Enum.sort/1. Isso é usado para garantir que as palavras sejam comparadas independentemente da ordem dos caracteres, facilitando a verificação de anagramas.
  """
  defp sort_codepoints(word) do
    word
    |> String.codepoints()
    |> Enum.sort()
  end
end
