defmodule PaintByNumber do

  @doc"""
  Esta função é a interface pública. Ela chama a função do_pallete_bit_size com bit_count inicializado como 1.
  """
  def palette_bit_size(color_count) do
    do_pallete_bit_size(color_count, 1)
  end

  @doc"""
  Essa função é privada (defp indica que é uma função privada). Ela é uma função recursiva que calcula o número de bits necessários para representar color_count cores em uma paleta. Ela compara bit_count com color_count e aumenta bit_count até que seja maior ou igual a color_count, retornando então o valor de bit_count.
  """
  defp do_pallete_bit_size(color_count, bit_count) do
    if Integer.pow(2, bit_count) >= color_count do
      bit_count
    else
      do_pallete_bit_size(color_count, bit_count + 1)
    end
  end

  @doc """
  Esta função retorna uma imagem vazia, representada como um binário de tamanho zero (<<0::0>>).
  """
  def empty_picture() do
    <<0::0>>
  end

  @doc """
  Esta função retorna uma imagem de teste, representada como um binário onde cada pixel é representado por 2 bits. A imagem é <<0::2, 1::2, 2::2, 3::2>>.
  """
  def test_picture() do
     <<0::2, 1::2, 2::2, 3::2>>
  end

  @doc """
  Adiciona um novo pixel à frente da imagem. O novo pixel é representado por pixel_color_index bits, seguido pelo conteúdo da imagem original.
  """
  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end

  @doc """
  Retorna o primeiro pixel da imagem, considerando o número de cores (color_count). Usa palette_bit_size para determinar o tamanho do pixel.
  """
  def get_first_pixel(picture, color_count) do
    palette_bit_size = palette_bit_size(color_count)
    case picture do
      <<pixel::size(palette_bit_size), _rest::bitstring>> -> pixel
      _ -> nil
    end
  end

  @doc """
  emove o primeiro pixel da imagem, considerando o número de cores (color_count). Usa palette_bit_size para determinar o tamanho do pixel.
  """
  def drop_first_pixel(picture, color_count) do
    palette_bit_size = palette_bit_size(color_count)
    case picture do
      <<_pixel::size(palette_bit_size), rest::bitstring>> -> rest
      _ -> <<>>
    end
  end

  @doc """
  Concatena duas imagens (picture1 e picture2) para formar uma única imagem.
  """
  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
