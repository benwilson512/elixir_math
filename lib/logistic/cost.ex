defmodule Math.Logistic.Cost do

  def avg_cost(f, points) do
    (1 / length(points)) * sum_cost(f, points, 0)
  end

  def sum_cost(f, [{x, y}| points], sum) do
    sum_cost(f, points, sum + cost(f.(x), y))
  end

  def cost(hx, 1), do: -1 * :math.log(hx)
  def cost(hx, 0), do: -1 * :math.log(1 - hx)
end
