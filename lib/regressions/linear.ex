# http://en.wikipedia.org/wiki/Simple_linear_regression
# Exchange.Calc.Regression.run([{1,1},{2,2},{3,3}])

defrecord Math.Regression.Linear.Result, products_avg: nil, x_avg: nil, y_avg: nil, x_sqr_avg: nil do

  def complete?(result) do
    result.products_avg && result.x_avg && result.y_avg && result.x_sqr_avg
  end
end

defmodule Math.Regression.Linear do

  alias Math.Regression.Linear.Result

  @doc """
  Generate a simple linear regression function

  ## Examples

    iex> Exchange.Calc.Regression.run([{1,1},{2,2},{4,8}]).(34)
    80.57142857142864

  """
  def run(points) do
    n = length(points)

    spawn_link(__MODULE__, :calculate_average,  [self, :products, points, n])
    spawn_link(__MODULE__, :calculate_average,  [self, :x_sqr, points, n])
    spawn_link(__MODULE__, :calculate_average,  [self, :x, points, n])
    spawn_link(__MODULE__, :calculate_average,  [self, :y, points, n])

    process Result.new
  end

  defp process(result) do
    if result.complete? do
      result |> build
    else
      receive do
        { :ok, data } -> result.update(data) |> process
      end
    end
  end

  def build(Result[products_avg: p_avg, x_avg: x_avg, y_avg: y_avg, x_sqr_avg: x_sqr_avg]) do
    slope = (p_avg - x_avg * y_avg) / (x_sqr_avg  - x_avg * x_avg)
    intercept = y_avg - slope * x_avg
    fn (x) -> slope * x + intercept end
  end

  def calculate_average(pid, :products, points, n) do
    pid <- { :ok, [{ :products_avg, sum_products(points) |> average(n) }] }
  end
  def calculate_average(pid, :x_sqr, points, n) do
    pid <- { :ok, [{ :x_sqr_avg, sum_x_sqr(points) |> average(n) }] }
  end
  def calculate_average(pid, :x, points, n) do
    pid <- { :ok, [{ :x_avg, sum_x(points) |> average(n) }] }
  end
  def calculate_average(pid, :y, points, n) do
    pid <- { :ok, [{ :y_avg, sum_y(points) |> average(n) }] }
  end

  def sum_products(points), do: Enum.reduce(points, 0, fn ({ x, y }, sum) -> sum + x * y end)
  def sum_x_sqr(points), do: Enum.reduce(points, 0, fn ({ x, _y }, sum) -> sum + x * x end)
  def sum_x(points), do: Enum.reduce(points, 0, fn ({ x, _y }, sum) -> sum + x end)
  def sum_y(points), do: Enum.reduce(points, 0, fn ({ _x, y }, sum) -> sum + y end)

  defp average(sum, n), do: sum / n

end