defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount * ((100 - discount) / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    (hourly_rate * 8) * 22
    |> apply_discount(discount)
    |> ceil()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    (budget / apply_discount(hourly_rate, discount))
    |> divide()
    |> Float.floor(1)
  end

  defp divide(value) do
    value / 8
  end
end
