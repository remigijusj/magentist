defmodule Magentist.Generator do
  def generate(config) do
    config["columns"]
    |> Enum.map(& values(config, &1))
    |> cartesian_product
  end

  defp values(config, column) do
    Map.get(config["values"], column, [nil])
  end

  defp cartesian_product([]), do: []
  defp cartesian_product(groups) do
    multiply(groups, []) |> Stream.map(& Enum.reverse(&1))
  end

  defp multiply([], elems), do: [elems]
  defp multiply([head | tail], elems) do
    Stream.flat_map(head, & multiply(tail, [&1 | elems]))
  end
end
