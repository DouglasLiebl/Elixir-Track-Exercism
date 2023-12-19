defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    elem(volume_pair, 1)
  end

  def to_milliliter(volume_pair) do
    cond do
      elem(volume_pair, 0) == :milliliter -> volume_pair
      elem(volume_pair, 0) == :cup -> cup_to_milliliter(elem(volume_pair, 1))
      elem(volume_pair, 0) == :fluid_ounce -> fluid_ounce_to_milliliter(elem(volume_pair, 1))
      elem(volume_pair, 0) == :teaspoon -> teaspoon_to_milliliter(elem(volume_pair, 1))
      elem(volume_pair, 0) == :tablespoon -> tablespoon_to_milliliter(elem(volume_pair, 1))
    end
  end

  defp cup_to_milliliter(volume), do: {:milliliter, (volume * 240)}
  defp fluid_ounce_to_milliliter(volume), do: {:milliliter, volume * 30}
  defp teaspoon_to_milliliter(volume), do: {:milliliter, volume * 5}
  defp tablespoon_to_milliliter(volume), do: {:milliliter, volume * 15}

  def from_milliliter(volume_pair, unit) do
    cond do
      unit == :milliliter -> volume_pair
      unit == :cup -> milliliter_to_cup(elem(volume_pair, 1))
      unit == :fluid_ounce -> milliliter_to_fluid_ounce(elem(volume_pair, 1))
      unit == :teaspoon -> milliliter_to_teaspoon(elem(volume_pair, 1))
      unit == :tablespoon -> milliliter_to_tablespoon(elem(volume_pair, 1))
    end
  end

  defp milliliter_to_cup(volume), do: {:cup, volume / 240}
  defp milliliter_to_fluid_ounce(volume), do: {:fluid_ounce, volume / 30}
  defp milliliter_to_teaspoon(volume), do: {:teaspoon, volume / 5}
  defp milliliter_to_tablespoon(volume), do: {:tablespoon, volume / 15}

  def convert({:teaspoon, volume}, :tablespoon), do: {:tablespoon, (volume / 3)}
  def convert({:cup, volume}, :fluid_ounce), do: {:fluid_ounce, (volume * 8)}
  def convert({:fluid_ounce, volume}, :teaspoon), do: {:teaspoon, (volume * 6)}
  def convert({:tablespoon, volume}, :cup), do: {:cup, (volume / 16)}
  
end
