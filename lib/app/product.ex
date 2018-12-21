# Exemplo de estruturas

defmodule Product do
  @moduledoc """
    Define a Product struct
  """

  defstruct name: nil, price: 1.99

  @doc """
    Get Product name with price

    # Parameters

    - `product` - A Product struct

    # Examples

    * milk = %Product{name: "Milk", price: 2.99}
    * rice = %Product{name: "Rice"}
    * Product.to_s(milk) => Milk - 2.99
    * Product.to_s(rice) => Rice - 1.99
  """
  def to_s(product) do
    IO.puts "#{product.name} - #{product.price}"
  end
end
