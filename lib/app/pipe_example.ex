# Exemplos pipe operator

[1,2,3] |> Enum.map(&(&1 * 2))
# => [2, 4, 6]

[1,2,3]
  |> Enum.map(&(&1 * 2))
  |> Enum.filter(&(&1 > 4))
# => [6]
