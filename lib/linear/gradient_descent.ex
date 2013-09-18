defmodule Math.Regression.GradientDescent do

  @doc """
  Computes a linear regression across an arbitrary number of features.
  
  @points: List of points, where each point is a tuple. Each
    entry in the tuple represents some dimension. The first
    member of every tuple must be a 1
    IE [{1,1,3},{1,2,3},{1,3,4}]

  @answers: A list containing the corresponding results that
    operating on the set of points should produce

  @alpha: The rate at which function changes the parameters
    of the hypothesis (thetas). Should be smaller for a larger
    number of points lest the algorithm go wildly out of control.
    Defaults to 1 / length(points)^2.

  @tolerance: How close the sum of the squared difference between
    consecutive iterations of theta must be before the function
    determines it has found the answer.

  Returns: A tuple containing the values of theta

  ## Examples

    iex> Math.Regression.GradientDescent.run([{1,1},{1,2},{1,3}], [2,4,6])
    {1.1387943346486253, 1.486898827903756}

  """
  def run(points, answers, alpha // nil, tolerance // 0.001) do
    m = length(points)
    if nil?(alpha) do
      alpha = 1 / :math.pow(m, 2)
    end
    thetas = 1..size(hd(points))
      |> Enum.map(&(&1 * 0))
      |> list_to_tuple
    update_thetas(thetas, points, answers, alpha, tolerance, m)
  end

  def update_thetas(thetas, points, answers, alpha, tolerance, m, sdiff // 1.0e300) do
    new_thetas = 0..(size(thetas) - 1)
      |> Enum.map(&(update_theta(&1, thetas, points, answers, alpha, m)))
      |> list_to_tuple
    
    new_sdiff = squared_diff(new_thetas, thetas)

    if new_sdiff > sdiff do
      raise "Algorithm growing uncontrollably, pick a lower alpha"
    end

    if new_sdiff < tolerance do
      new_thetas
    else
      update_thetas(new_thetas, points, answers, alpha, tolerance, m, sdiff)
    end
  end

  def update_theta(index_j, thetas, points, answers, alpha, m) do
    theta_j = elem(thetas, index_j)
    theta_j - alpha * gradient(theta_j, index_j, thetas, points, answers, m)
  end

  def gradient(theta_j, index_j, thetas, points, answers, m) do
    gradient(theta_j, index_j, thetas, points, answers, m, 0)
  end

  defp gradient(_theta_j, _index_j, _thetas, [], [], _m, sum), do: sum
  defp gradient(theta_j, index_j, thetas, [p | points], [y | answers], m, sum) do
    grad = (hypothesis(thetas, p) - y) * elem(p, index_j)
    gradient(theta_j, index_j, thetas, points, answers, m, sum + (grad/m))
  end


  defp hypothesis(thetas, point) do
    thetas |> Math.tdot_product(point)
  end

  defp squared_diff(t1, t2), do: squared_diff(t1, t2, 0, size(t1), 0)
  defp squared_diff(_t1, _t2, i, s, sum) when i == s, do: (sum / s)
  defp squared_diff(t1, t2, i, s, sum) do
    squared_diff(t1, t2, i + 1, s, sum + :math.pow(  (elem(t1, i) - elem(t2, i)), 2))
  end

end
