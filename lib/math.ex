defmodule Math do
  def dot_product(l1, l2) when is_list(l2), do: dot_product(l1, l2, 0)
  def dot_product([], [], result), do: result
  def dot_product([h1 | v1], [h2 | v2], sum) do
    dot_product(v1, v2, sum + h1 * h2)
  end

  def tdot_product(t1, t2) when is_tuple(t2), do: tdot_product(t1, t2, 0, 0)
  def tdot_product(t1, _t2, i, sum) when i == size(t1), do: sum
  def tdot_product(t1, t2, i, sum) do
    tdot_product(t1, t2, i + 1, sum + elem(t1, i) * elem(t2, i))
  end

  def squared_diff(t1, t2), do: squared_diff(t1, t2, 0, size(t1), 0)
  defp squared_diff(_t1, _t2, i, s, sum) when i == s, do: (sum / s)
  defp squared_diff(t1, t2, i, s, sum) do
    squared_diff(t1, t2, i + 1, s, sum + :math.pow((elem(t1, i) - elem(t2, i)), 2))
  end
end
