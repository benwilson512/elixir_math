defmodule MathTest do
  use ExUnit.Case

  import Math, only: [
    tdot_product: 2
  ]

  test "tdot_product can handle a tuple" do
    t1 = {1,2,3}
    t2 = {2,3,4}
    assert t1 |> tdot_product(t2) == (1*2) + (2*3) + (3*4)
  end
end
