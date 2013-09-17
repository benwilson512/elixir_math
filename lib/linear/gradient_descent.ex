defmodule Math.Regression.GradientDescent do

  def update_params(parameters, points, answers, alpha) do
    0..length(parameters)
      |> Enum.map(&(update_param(&1, parameters, points, answers, alpha)))
  end


  def update_param(index_j, parameters, points, answers, alpha) do
    param_j = elem(parameters, index_j)
    param_j - alpha * sum_dc(param_j, index_j, parameters, points, answers)
  end

  def sum_dc(param_j, index_j, parameters, points, answers) do
    sum_dc(param_j, index_j, parameters, points, answers, 0)
  end

  defp sum_dc(_param_j, _index_j, _parameters, [], [], sum), do: sum

  defp sum_dc(param_j, index_j, parameters, [p | points], [y | answers], sum) do
    result = sum + (hypothesis(parameters, p) - y) * elem(p, index_j)
    sum_dc(param_j, index_j, parameters, points, answers, result)
  end

  def hypothesis(parameters, point) do
    parameters |> Math.tdot_product(point)
  end

end