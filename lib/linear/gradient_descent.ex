defmodule Math.Regression.GradientDescent do

  def update_thetas(thetas, points, answers, alpha, tolerance, m) do
    IO.inspect thetas
    new_thetas = 0..(size(thetas) - 1)
      |> Enum.map(&(update_theta(&1, thetas, points, answers, alpha, m)))
      |> list_to_tuple
    
    sdiff = squared_diff(new_thetas, thetas)
    IO.inspect sdiff
    if sdiff < tolerance do
      new_thetas
    else
      update_thetas(new_thetas, points, answers, alpha, tolerance, m)
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
