defmodule Secrets do
  def secret_add(secret) do
    fn x -> secret + x end
  end

  def secret_subtract(secret) do
    fn x -> x - secret end
  end

  def secret_multiply(secret) do
    fn x -> secret * x end
  end

  def secret_divide(secret) do
    fn x -> floor(x / secret) end
  end

  def secret_and(secret) do
    fn x -> Bitwise.band(x, secret) end
  end

  def secret_xor(secret) do
    fn x -> Bitwise.bxor(x, secret) end
  end

  def secret_combine(secret_function1, secret_function2) do
    fn arg -> secret_function1.(arg) |> secret_function2.() end
  end
end
