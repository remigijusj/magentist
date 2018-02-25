defmodule Magentist.Generator do
  def generate(config) do
    columns = Map.get(config, "columns", [])
    Stream.concat([names(columns)], data_rows(columns))
  end

  def names(columns) do
    columns
    |> Enum.map(& &1["name"])
  end

  def data_rows(columns) do
    columns
    |> Enum.map(& values(&1))
    |> cartesian_product
  end

  defp values(column) do
    Map.get(column, "values", [nil])
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
