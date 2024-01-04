defmodule BoutiqueInventory do

  @doc """
  Essa função usa Enum.sort_by/3 para ordenar a lista inventory com base no preço (&1.price). Aqui, &1 refere-se ao primeiro argumento da função anônima passada para Enum.sort_by/3, que é cada elemento da lista inventory. Assumindo que cada elemento da lista tenha um campo price, a função irá ordenar os elementos com base em seus preços.
  """
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &{&1.price})
  end

  @doc """
  Esta função utiliza Enum.filter/2 para retornar uma lista contendo apenas os elementos da inventory cujo campo price é nil. Isso significa que ela filtra apenas os itens que têm preço ausente.
  """
  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  @doc """
  Aqui, a função usa Enum.map/2 para criar uma nova lista onde os nomes dos itens em inventory são atualizados. A função anônima dentro de Enum.map/2 substitui todas as instâncias de old_word por new_word no campo name de cada item.
  """
  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      %{item | name: String.replace(item.name, old_word, new_word)}
    end)
  end

  @doc """
  Esta função aumenta a quantidade (count) de um item específico. O item é representado por um mapa com a chave quantity_by_size. A função Enum.into/3 é usada para iterar sobre o mapa quantity_by_size, adicionando count à quantidade existente para cada tamanho.
  """
  def increase_quantity(%{quantity_by_size: quantity_by_size} = item, count) do
    %{item | quantity_by_size: Enum.into(quantity_by_size, %{}, fn {k, v} -> {k, v + count} end)}
  end

  @doc """
  Essa função calcula a quantidade total de um item considerando as quantidades associadas a diferentes tamanhos no mapa quantity_by_size. Enum.reduce/3 é utilizado para somar todas as quantidades e produzir o resultado final.
  """
  def total_quantity(%{quantity_by_size: quantity_by_size}) do
    Enum.reduce(quantity_by_size, 0, fn {_, n}, acc -> acc + n end)
  end
end
