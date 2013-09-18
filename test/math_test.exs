defmodule MathTest do
  use ExUnit.Case

  import Math, only: [
    tdot_product: 2
  ]

  import Math.Regression.GradientDescent, only: [
    sum_dc: 6,
    run: 6
  ]

  test "tdot_product can handle a tuple" do
    t1 = {1,2,3}
    t2 = {2,3,4}
    assert t1 |> tdot_product(t2) == (1*2) + (2*3) + (3*4)
  end

  test "sum_dc sums stuff properly" do
    fun = fn (params, points) -> params |> tdot_product(points) end
    params = {0, 2}
    points = [{1,1},{1,2},{1,3}]
    answers = [2,3,4]
    index_j = 0
    param_j = elem(params, index_j)
    assert sum_dc(param_j, index_j, params, fun, points, answers) == 3
  end

  test "run works properly" do
    fun = fn (params, points) -> params |> tdot_product(points) end
    params = {0,0}
    points = [{1,1},{1,2},{1,3},{1,4},{1,5}]
    answers = [2,4,6,8,10]
    alpha = 0.01
    tolerance = 0.001
    assert run(params,fun, points, answers, alpha, tolerance) == {0.18258946721624858, 1.9196782316874186}
  end

  test "lets benchmark run" do
    fun = fn (params, points) -> params |> tdot_product(points) end
    num_points = 100
    answers = 1..num_points |> Enum.map &(&1)
    points = lc x inlist answers, do: {1, x}
    params = {0,0}
    alpha = 0.000001
    tolerance = 0.001
    stuff = [
      params, fun, points, answers, alpha, tolerance
    ]
    # IO.inspect stuff
    # run(params,fun, points, answers, alpha, tolerance)
    # IO.puts inspect :timer.tc(Math.Regression.GradientDescent, :run, stuff)
    assert true
  end

end
