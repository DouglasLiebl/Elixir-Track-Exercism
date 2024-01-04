defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    extract(data, extract_keys(path))
  end

  defp extract(data, []), do: data
  defp extract(nil, _), do: nil
  defp extract(data, [head | tail]) do
    extract(data[head], tail)
  end

  defp extract_keys(path) do
    String.split(path, ".", trim: true)
  end

  def get_in_path(data, path) do
    keys = extract_keys(path)
    get_in(data, keys)
  end
end
