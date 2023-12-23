defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  @doc """
  Esta função verifica se a hora de uma determinada data e hora (datetime) é antes do meio-dia (antes das 12 horas). Retorna true se for antes do meio-dia, false caso contrário.
  """
  def before_noon?(datetime) do
    if datetime.hour < 12, do: true, else: false
  end

  @doc """
  Esta função calcula a data de retorno esperada com base na data e hora de checkout fornecida (checkout_datetime). Se a hora de checkout for antes do meio-dia, adiciona 28 dias à data de checkout; caso contrário, adiciona 29 dias.
  """
  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime), do: Date.add(checkout_datetime, 28), else: Date.add(checkout_datetime, 29)
  end

  @doc """
  Esta função calcula o número de dias de atraso entre a data de retorno planejada (planned_return_date) e a data e hora de retorno real (actual_return_datetime). O resultado é obtido convertendo a data e hora real para uma data, calculando a diferença em dias e garantindo que o resultado seja pelo menos 0 (sem atraso).
  """
  def days_late(planned_return_date, actual_return_datetime) do
     NaiveDateTime.to_date(actual_return_datetime)
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  @doc"""
  Esta função verifica se uma data específica, representada como um mapa com chaves year, month e day, é uma segunda-feira. Isso é feito usando a função Date.day_of_week/1 para obter o dia da semana e comparando com 1, que representa segunda-feira.
  """
  def monday?(%{year: year, month: month, day: day}) do
    Date.day_of_week(Date.new!(year, month, day)) == 1
  end

  @doc """
  Esta função realiza o cálculo da taxa de atraso com base nas informações de checkout (checkout), retorno (return) e uma taxa específica (rate). Primeiro, obtém as datas de retorno esperadas e reais usando as funções datetime_from_string/1 e return_date/1.
  Calcula o número de dias de atraso usando a função days_late/2.
  Multiplica o número de dias de atraso pela taxa para obter a taxa de atraso bruta.
  Em seguida, aplica uma redução de 50% à taxa de atraso bruta se o retorno ocorrer em uma segunda-feira
  """
  def calculate_late_fee(checkout, return, rate) do
    expected_return = datetime_from_string(checkout) |> return_date()
    actual_return = datetime_from_string(return)

    (days_late(expected_return, actual_return) * rate)
    |> then(fn f -> if monday?(actual_return), do: floor(f * 0.5), else: f end)
  end
end
