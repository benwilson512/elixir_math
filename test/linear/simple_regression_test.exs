# l = 1..1_000_000 |> Enum.map fn(_) -> :random.uniform * :random.uniform(1_000_000) end 
# ll = lc x inlist l, do: {x, x}
# IO.puts inspect :timer.tc(Exchange.Calc.Regression, :run, [ll])

defmodule SimpleRegressionTest do
  use ExUnit.Case

  doctest Math.Linear.SimpleRegression

  import Math.Linear.SimpleRegression, only: [
    sum_products: 1,
    sum_x_sqr: 1,
    sum_x: 1,
    sum_y: 1,
    run: 1
  ]

  test "sum_x returns summed x points" do
    points = [{1,2},{2,3},{3,4}]
    assert sum_x(points) == 6
  end

  test "sum_y returns summed x points" do
    points = [{1,2},{2,3},{3,4}]
    assert sum_y(points) == 9
  end

  test "sum of products returns the sums of products" do
    points = [{1,1},{2,4},{3,6}]
    assert sum_products(points) == ((1*1) + (2*4) + (3*6))
  end

  test "sum of x squared works" do
    points = [{1,1},{2,4},{3,6}]
    assert sum_x_sqr(points) == ((1*1) + (2*2) + (3*3))
  end

  test "linear_regression produces the correct intercept / slope" do
    points = [{1, 2},{2,4},{3,6}]
    f = run(points)
    assert f.(10) == 20
  end
end
