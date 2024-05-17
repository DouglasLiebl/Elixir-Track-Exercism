defmodule Newsletter do
  def read_emails(path) do
    path
    |> File.stream!()
    |> Enum.map(&String.replace(&1, "\n", ""))
    |> Enum.to_list()
  end

  def open_log(path) do
    case File.open(path, [:write]) do
      {:ok, pid} -> pid
      {:error, reason} -> {:error, reason}
    end
  end

  def log_sent_email(pid, email) do
    IO.write(pid, "#{email}\n")
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    pid = open_log(log_path)

    emails_path
    |> read_emails()
    |> Enum.each(fn email ->
      case send_fun.(email) do
        :ok -> log_sent_email(pid, "#{email}")
        _ -> :ok
      end
    end)

    close_log(pid)
  end


end
