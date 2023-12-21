defmodule TakeANumber do

  @doc """
  Essa função é responsável por iniciar o processo. Quando chamada, ela cria um novo processo utilizando a função spawn/1 e executa a função loop/1 nesse novo processo.
  """
  def start() do
    spawn(&loop/0)
  end

  @doc """
  Esta é a função principal que implementa o loop de recebimento de mensagens. Ela tem um parâmetro opcional number com um valor padrão de 0.
  O bloco receive é usado para aguardar a chegada de mensagens assíncronas.

  {:report_state, pid} -> send(pid, number) |> loop():
  Se a mensagem recebida for {:report_state, pid}, onde pid é o identificador de processo do remetente, a função envia de volta o valor atual de number para esse processo usando send/2 e em seguida continua o loop chamando loop() recursivamente.

  {:take_a_number, pid} -> send(pid, number + 1) |> loop():
  Se a mensagem for {:take_a_number, pid}, a função envia de volta o valor incrementado de number para o processo remetente e continua o loop chamando loop() recursivamente.

  :stop -> nil:
  Se a mensagem for :stop, a função simplesmente retorna nil, encerrando o loop.

  _ -> loop(number):
  Qualquer outra mensagem não especificada nas cláusulas anteriores faz com que o loop continue chamando loop(number) recursivamente.
  """
  defp loop(number \\ 0) do
    receive do
      {:report_state, pid} ->
        send(pid, number) |> loop()
      {:take_a_number, pid} ->
        send(pid, number + 1) |> loop()
      :stop ->
        nil
      _ ->
        loop(number)
    end
  end
end
