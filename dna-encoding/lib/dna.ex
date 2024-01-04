defmodule DNA do

  @doc """
  Esta função recebe um ponto de código (code_point), que representa um nucleotídeo, e o mapeia para um valor codificado em binário de 4 bits. Usa uma expressão case para realizar essa correspondência.
  """
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s   -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  @doc """
  Esta função faz o oposto da encode_nucleotide. Recebe um valor codificado em binário de 4 bits (encoded_code) e o mapeia de volta para o nucleotídeo correspondente usando uma expressão case.
  """
  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  @doc """
  Esta função pública é a interface principal para codificar sequências de DNA. Inicializa a chamada interna da função encode com uma sequência vazia (<<0::0>>). As funções internas encode são usadas para processar cada elemento da sequência de DNA recursivamente e construir a representação codificada em binário.
  """
  def encode(dna) do
    encode(dna, <<0::0>>)
  end

  @doc """
  Função privada (defp) que atua como o caso base para a recursão na função encode. Quando a lista de DNA estiver vazia, retorna o valor codificado acumulado até esse ponto.
  """
  defp encode([], encoded_value), do: encoded_value

  @doc """
  Função privada que é chamada recursivamente para processar cada elemento da sequência de DNA. Concatena o valor codificado atual (encoded_value) com a representação codificada do nucleotídeo na cabeça da lista.
  """
  defp encode([head | tail], encoded_value) do
    encode(tail, <<encoded_value::bitstring, encode_nucleotide(head)::4>>)
  end

  @doc """
  Esta função pública é a interface principal para decodificar sequências de DNA. Inicializa a chamada interna da função decode com uma string vazia (''). As funções internas decode são usadas para processar cada grupo de 4 bits recursivamente e construir a representação decodificada.
  """
  def decode(dna) do
    decode(dna, '')
  end

  @doc """
  Função privada que atua como o caso base para a recursão na função decode. Quando o binário estiver vazio, retorna a string decodificada acumulada até esse ponto.
  """
  defp decode(<<0::0>>, decoded_value), do: decoded_value

  @doc """
  Função privada que é chamada recursivamente para processar cada grupo de 4 bits da sequência binária. Concatena a representação decodificada do grupo de 4 bits (head) com o valor decodificado acumulado até esse ponto.
  """
  defp decode(<<head::4, tail::bitstring>>, decoded_value) do
    decode(tail, decoded_value ++ [decode_nucleotide(head)])
  end

end
