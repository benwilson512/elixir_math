defmodule Math.Regression.GradientDescent do

  def run(params, fun, points, answers, alpha, tolerance) do
    new_params = 0..(size(params) - 1)
      |> Enum.map(&(update_param(&1, params, fun, points, answers, alpha)))
      |> list_to_tuple

    if delta(new_params, params) < tolerance do
      new_params
    else
      run(new_params, fun, points, answers, alpha, tolerance)
    end
  end

  def update_param(index_j, params, fun, points, answers, alpha) do
    param_j = elem(params, index_j)
    param_j - alpha * sum_dc(param_j, index_j, params, fun, points, answers)
  end

  defp delta(t1, t2),         do: delta(t1, t2, 0, size(t1), 0)
  defp delta(_t1, _t2, i, s, sum) when i == s, do: sum
  defp delta(t1, t2, i, s, sum) do
    delta(t1, t2, i + 1, s, sum + abs(elem(t1, i) - elem(t2, i)))
  end

  def sum_dc(param_j, index_j, params, fun, points, answers) do
    sum_dc(param_j, index_j, params, fun, points, answers, 0)
  end

  defp sum_dc(_param_j, _index_j, _params, _fun, [], [], sum), do: sum

  defp sum_dc(param_j, index_j, params, fun, [p | points], [y | answers], sum) do
    val = (fun.(params, p) - y) * elem(p, index_j)
    result = sum + val
    sum_dc(param_j, index_j, params, fun, points, answers, result)
  end

end
