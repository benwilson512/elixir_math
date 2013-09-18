defmodule GradientDescentTest do
  use ExUnit.Case

  import Math.Regression.GradientDescent, only: [
    gradient: 6,
    update_theta: 6,
    update_thetas: 6
  ]

  test "gradient should be zero when theta is exactly right" do
    thetas = {0, 2}
    points = [{1,1},{1,2},{1,3},{1,4}]
    answers = [2,4,6,8]
    m = length(points)
    # Gradient first theta
    index_0 = 0
    theta_0 = elem(thetas, index_0)
    assert gradient(theta_0, index_0, thetas, points, answers, m) == 0
    # Gradient second theta
    index_1 = 1
    theta_1 = elem(thetas, index_1)
    assert gradient(theta_1, index_1, thetas, points, answers, m) == 0
  end

  test "gradient should be negative when theta is too small" do
    thetas = {0, 0}        # Slope of 0
    points = [{1,1},{1,5}] # Slope of 1
    answers = [1,5]
    m = length(points)
    # Gradient first theta
    index_0 = 0
    theta_0 = elem(thetas, index_0)
    assert gradient(theta_0, index_0, thetas, points, answers, m) < 0
    # Gradient second theta
    index_1 = 1
    theta_1 = elem(thetas, index_1)
    assert gradient(theta_1, index_1, thetas, points, answers, m) < 0
  end

  test "gradient should be positive when theta is too large" do
    thetas = {0, 3}        # Slope of 3
    points = [{1,1},{1,2}] # Slope of 1
    answers = [1,2]
    m = length(points)
    # Gradient first theta
    index_0 = 0
    theta_0 = elem(thetas, index_0)
    assert gradient(theta_0, index_0, thetas, points, answers, m) > 0
    # Gradient second theta
    index_1 = 1
    theta_1 = elem(thetas, index_1)
    assert gradient(theta_1, index_1, thetas, points, answers, m) > 0
  end

  test "update_theta should be unchanged for correct thetas" do
    thetas = {0, 2}
    points = [{1,1},{1,2},{1,3},{1,4}]
    answers = [2,4,6,8]
    m = length(points)
    alpha = 0.1
    # First theta
    index_0 = 0
    theta_0 = elem(thetas, index_0)
    assert update_theta(index_0, thetas, points, answers, alpha, m) == theta_0
    # Second theta
    index_1 = 1
    theta_1 = elem(thetas, index_1)
    assert update_theta(index_1, thetas, points, answers, alpha, m) == theta_1
  end

  test "update_theta should change for incorrect thetas" do
    thetas = {0, 3} #second theta is incorrect
    points = [{1,1},{1,2},{1,3},{1,4},{1,5}]
    answers = [2,4,6,8,10]
    m = length(points)
    alpha = 0.1
    # First theta
    index_0 = 0
    theta_0 = elem(thetas, index_0)
    assert update_theta(index_0, thetas, points, answers, alpha, m) != theta_0
    # Second theta
    index_1 = 1
    theta_1 = elem(thetas, index_1)
    assert update_theta(index_1, thetas, points, answers, alpha, m) != theta_1
  end

  test "update_theta works properly" do
    thetas = {0,0}
    points = [{1,1},{1,2},{1,3}]
    answers = [2,4,6]
    alpha = 0.1
    tolerance = 0.001
    m = length(points)
    assert update_thetas(thetas, points, answers, alpha, tolerance, m) == {0.6809901234567902, 1.6653922633744855}
  end

  # test "run handles large numbers" do
  #   num_points = 1_000_000
  #   base = 1..num_points |> Enum.map &(&1)
  #   answers = base |> Enum.map &(&1 * 100)
  #   points = lc x inlist base, do: {1, x}
  #   m = length(points)
  #   # alpha = 1 / (num_points * num_points * 10)
  #   stuff = [
  #     points, answers
  #   ]
  #   # IO.inspect update_thetas(thetas,fun, points, answers, alpha, tolerance, m)
  #   IO.puts inspect :timer.tc(Math.Regression.GradientDescent, :run, stuff)
  #   assert true
  # end

  defp gen_default_data(num_points) do
    fun = fn (thetas, points) -> thetas |> Math.tdot_product(points) end
    # answers = 1..num_points |> Enum.map fn(_) -> :random.uniform * :random.uniform(num_points) end 
    answers = 1..num_points |> Enum.take(num_points)
    points  = lc x inlist answers, do: {1, x}
    m       = length(points)
    {fun, points, answers, m}
  end
end
