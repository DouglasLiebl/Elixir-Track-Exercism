defmodule WineCellar do
  def explain_colors do
    [white: "Fermented without skin contact.", red: "Fermented with skin contact using dark-colored grapes.", rose: "Fermented with some skin contact, but not enough to qualify as a red wine."]
  end

  def filter(cellar, color, opts \\ [])
  def filter(cellar, color, opts), do: Keyword.get_values(cellar, color) |> filter_by_opts(opts)
  @doc """
  Nesta linha é feita a filtragem por cor com Keyword.get_values(vinhos, cor), o retorno dessa função será passado para a função filter_by_opts() agora como uma lista de tuplas. ex:
    [
    white: {"Chardonnay", 2015, "Italy"},
    white: {"Pinot grigio", 2017, "Germany"},
    red: {"Pinot noir", 2016, "France"},
    rose: {"Dornfelder", 2018, "Germany"}
    ]
  Filtrando pela cor :white o retorno será:
    [
    {"Chardonnay", 2015, "Italy"},
    {"Pinot grigio", 2017, "Germany"}
    ]
  A função filter_by_opts() terá a lista anterior como primeiro parâmetro e os outros filtros das seguintes formas:
    -> year: 2015
    -> [year: 2015, country: "Italy"]
    -> year: 2015, country: "Italy"
  """

  @doc """
  Esta cláusula da função lida com o caso em que a lista de opções não está vazia e a primeira opção é {:year, year}. Isso significa que o usuário deseja filtrar a adega pelo ano.
  {:year, year} é uma tupla que indica que estamos filtrando pelo ano, e year é a variável que contém o valor do ano.
  A função utiliza o operador de pipeline (|>) para encadear chamadas de função. Primeiro, ela chama a função filter_by_year(year) para filtrar a adega pelo ano especificado. Em seguida, ela chama recursivamente a função filter_by_opts(tail) para aplicar as opções restantes na lista (tail).
  Isso constrói uma série de chamadas encadeadas, onde a adega é filtrada pelo ano e, em seguida, pelas opções restantes.
  """
  defp filter_by_opts(cellar, [{:year, year} | tail]), do: cellar |> filter_by_year(year) |> filter_by_opts(tail)

  @doc """
  Similar à primeira cláusula, esta lida com o caso em que a lista de opções não está vazia e a primeira opção é {:country, country}. Isso significa que o usuário deseja filtrar a adega pelo país.
  {:country, country} é uma tupla que indica que estamos filtrando pelo país, e country é a variável que contém o valor do país.
  A função utiliza o operador de pipeline para encadear chamadas de função. Primeiro, ela chama a função filter_by_country(country) para filtrar a adega pelo país especificado. Em seguida, ela chama recursivamente a função filter_by_opts(tail) para aplicar as opções restantes na lista (tail).
  """
  defp filter_by_opts(cellar, [{:country, country} | tail]), do: cellar |> filter_by_country(country) |> filter_by_opts(tail)

  defp filter_by_opts(cellar, []), do: cellar



  defp filter_by_year(wines, year) #  Esta é a assinatura da função principal
  @doc """
  Esta é uma cláusula de correspondência de padrões que trata o caso base quando a lista de vinhos está vazia. Nesse caso, a função retorna uma lista vazia.
  """
  defp filter_by_year([], _year), do: []

  @doc """
  Esta cláusula lida com o caso em que a lista de vinhos não está vazia. Ela desestrutura a cabeça da lista (o primeiro elemento) como {_, year, _} = wine, onde _ é uma variável de espaço reservado para partes da tupla que não nos importam. O código verifica se o ano do vinho é igual ao ano fornecido como argumento. Se for, o vinho é mantido na lista resultante, caso contrário, é descartado. Em seguida, a função é chamada recursivamente com a cauda da lista (tail) para continuar o processo de filtragem.
  """
  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  @doc """
   Esta cláusula é acionada se o primeiro vinho na lista não corresponder ao ano fornecido como argumento. Nesse caso, o vinho é descartado, e a função é chamada recursivamente com o restante da lista (tail).
  """
  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
