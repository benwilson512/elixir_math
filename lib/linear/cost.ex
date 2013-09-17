defmodule Math.Linear.Cost do
  @doc """
  Calculates the cost (squared error) of a hypothesis over
  a given data set

  ## Examples

    iex> Math.Linear.Cost.squared_error(&(&1 + 2), [{1,1},{2,2},{4,8}])

  """
  def squared_error(hypothesis, points) do
    (1/(2 * length(points))) * square_sum(hypothesis, points, 0)
  end

  def square_sum(_f, [], sum), do: sum
  def square_sum(f, [{x, y} | points], sum) do
    square_sum(f, points, sum + cost(f.(x), y))
  end

  def cost(hx, y), do: :math.pow(hx - y, 2)
end