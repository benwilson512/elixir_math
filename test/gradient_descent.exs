defmodule GradientDescentTest do
  use ExUnit.Case

  import Math.Regression.GradientDescent, only: [
    hypothesis: 1
  ]

  test "hypothesis produces the vector product of 2 vectors" do
    v1 = [1,2,3,4]
    v2 = [2,3,4,5]
    assert hypothesis(v1, v2) == (1*2) + (2*3) + (3*4) + (4*5)
  end
end
