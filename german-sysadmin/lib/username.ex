defmodule Username do
  def sanitize(username) do
    case username do
      "ä" -> "ae"
      "ö" -> "oe"
      "ü" -> "ue"
      "ß" -> "ss"
    end
    # Please implement the sanitize/1 function
  end
end
