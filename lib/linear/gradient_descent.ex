defmodule Math.Linear.GradientDescent do

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
    Defaults to 1 / length(points)^2. Hand tuning recommended.

  @tolerance: How close the sum of the squared difference between
    consecutive iterations of theta must be before the function
    determines it has found the answer.

  Returns: A tuple containing the values of theta

  ## Examples

    iex> Math.Linear.GradientDescent.run([{1,1},{1,2},{1,3}], [2,4,6])
    {0.6830945381414766, 1.682866297760519}

  """
  def run(points, answers, alpha // nil, tolerance // 0.001) do
    m = length(points)
    if nil?(alpha) do
      alpha = 1 / :math.pow(m, 2)
    end
    thetas = 1..size(hd(points))
      |> Enum.map(&(&1 * 0))
      |> list_to_tuple

    update_thetas thetas, points, answers, alpha, tolerance, m
  end

  def update_thetas(thetas, points, answers, alpha, tolerance, m, sdiff // 1.0e300) do
    new_thetas = 0..(size(thetas) - 1)
      |> Enum.map(&(update_theta(&1, thetas, points, answers, alpha, m)))
      |> list_to_tuple
    
    new_sdiff = Math.squared_diff(new_thetas, thetas)

    if new_sdiff > sdiff do
      IO.puts "Algorithm out of control!"
    else
      if new_sdiff < tolerance do
        new_thetas
      else
        update_thetas(new_thetas, points, answers, alpha, tolerance, m, new_sdiff)
      end
    end
  end

  def update_theta(index_j, thetas, points, answers, alpha, m) do
    theta_j = elem(thetas, index_j)
    theta_j - (alpha / m) * gradient(theta_j, index_j, thetas, points, answers)
  end

  @doc """
    Computes the partial derivative of the cost function
    with respect to theta_j
  """
  def gradient(theta_j, index_j, thetas, points, answers) do
    gradient(theta_j, index_j, thetas, points, answers, 0)
  end

  defp gradient(_theta_j, _index_j, _thetas, [], [], sum), do: sum
  defp gradient(theta_j, index_j, thetas, [p | points], [y | answers], sum) do
    grad = (hypothesis(thetas, p) - y) * elem(p, index_j)
    gradient(theta_j, index_j, thetas, points, answers, sum + grad)
  end

  defp hypothesis(thetas, point) do
    thetas |> Math.tdot_product(point)
  end

end
