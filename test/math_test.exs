defmodule MathTest do
  use ExUnit.Case

  import Math, only: [
    tdot_product: 2
  ]

  import Math.Regression.GradientDescent, only: [
    hypothesis: 2,
    sum_dc: 5,
    update_param: 5
  ]

  test "tdot_product can handle a tuple" do
    t1 = {1,2,3}
    t2 = {2,3,4}
    assert t1 |> tdot_product(t2) == (1*2) + (2*3) + (3*4)
  end

  test "hypothesis produces the vector product of 2 vectors" do
    v1 = {1,2,3,4}
    v2 = {2,3,4,5}
    assert hypothesis(v1, v2) == (1*2) + (2*3) + (3*4) + (4*5)
  end

  test "sum_dc sums stuff properly" do
    parameters = {0,2}
    points = [{1,1},{1,2},{1,3}]
    answers = [2,3,4]
    index_j = 0
    param_j = elem(parameters, index_j)
    assert sum_dc(param_j, index_j, parameters, points, answers) == 3
  end

  test "update_param works properly" do
    parameters = {0,2}
    points = [{1,1},{1,2},{1,3}]
    answers = [2,3,4]
    alpha = 1
    index_j = 0
    assert update_param(index_j, parameters, points, answers, alpha) == -3
  end


end
