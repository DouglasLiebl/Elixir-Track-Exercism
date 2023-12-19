defmodule GuessingGame do
  def compare(secret_number, guess) when secret_number == guess, do: "Correct"
  def compare(_secret_number), do: "Make a guess"
  def compare(_secret_number, :no_guess), do: "Make a guess"
  def compare(secret_number, guess) when abs(secret_number - guess) == 1, do: "So close"
  def compare(secret_number, guess) when guess > secret_number, do: "Too high"
  def compare(secret_number, guess) when guess < secret_number, do: "Too low"
end
