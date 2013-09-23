# points = [{1,1},{1,2},{1,3},{1,4},{1,5}]
# answers = [2,4,6,8,10]
# Math.Linear.GradientDescent.run(points, answers)

defmodule Logistic.GradientDescentTest do
  use ExUnit.Case

  import Math.Logistic.GradientDescent, only: [
    gradient: 5,
    # update_theta: 6,
    run: 2,
    run: 3,
    run: 4,
    hypothesis: 2
  ]

  test "how does run work?" do
    points = [{1,1,1},{1,2,2},{1,3,3},{1,4,4},{1,5,5},{1,6,6},{1,7,7},{1,8,8}]
    answers = [0,0,0,0,1,1,1,1]
    thetas = run(points, answers, 0.01)
    # IO.inspect thetas
    # IO.inspect hypothesis(thetas, {1,6,6})
    assert true
  end

  test "hypothesis returns the correct results" do
    point = {1,3}
    thetas = {2, 4}
    assert hypothesis(thetas, point) == 0.9999991684719722
  end

  # test "gradient should be zero when theta is exactly right" do
  #   thetas = {0.0, 0.008}
  #   points = [{1,1},{1,2},{1,3},{1,4},{1,5},{1,6},{1,7},{1,8}]
  #   answers = [0,0,0,0,1,1,1,1]
  #   # Gradient first theta
  #   index_0 = 0
  #   theta_0 = elem(thetas, index_0)
  #   assert gradient(theta_0, index_0, thetas, points, answers) == 0
  #   # Gradient second theta
  #   index_1 = 1
  #   theta_1 = elem(thetas, index_1)
  #   assert gradient(theta_1, index_1, thetas, points, answers) == 13
  # end

  # test "gradient should be negative when theta is too small" do
  #   thetas = {0, 0}        # Slope of 0
  #   points = [{1,1},{1,5}] # Slope of 1
  #   answers = [1,5]
  #   m = length(points)
  #   # Gradient first theta
  #   index_0 = 0
  #   theta_0 = elem(thetas, index_0)
  #   assert gradient(theta_0, index_0, thetas, points, answers, m) < 0
  #   # Gradient second theta
  #   index_1 = 1
  #   theta_1 = elem(thetas, index_1)
  #   assert gradient(theta_1, index_1, thetas, points, answers, m) < 0
  # end

  # test "gradient should be positive when theta is too large" do
  #   thetas = {0, 3}        # Slope of 3
  #   points = [{1,1},{1,2}] # Slope of 1
  #   answers = [1,2]
  #   m = length(points)
  #   # Gradient first theta
  #   index_0 = 0
  #   theta_0 = elem(thetas, index_0)
  #   assert gradient(theta_0, index_0, thetas, points, answers, m) > 0
  #   # Gradient second theta
  #   index_1 = 1
  #   theta_1 = elem(thetas, index_1)
  #   assert gradient(theta_1, index_1, thetas, points, answers, m) > 0
  # end

  # test "update_theta should be unchanged for correct thetas" do
  #   thetas = {0, 2}
  #   points = [{1,1},{1,2},{1,3},{1,4}]
  #   answers = [2,4,6,8]
  #   m = length(points)
  #   alpha = 0.1
  #   # First theta
  #   index_0 = 0
  #   theta_0 = elem(thetas, index_0)
  #   assert update_theta(index_0, thetas, points, answers, alpha, m) == theta_0
  #   # Second theta
  #   index_1 = 1
  #   theta_1 = elem(thetas, index_1)
  #   assert update_theta(index_1, thetas, points, answers, alpha, m) == theta_1
  # end

  # test "update_theta should change for incorrect thetas" do
  #   thetas = {0, 3} #second theta is incorrect
  #   points = [{1,1},{1,2},{1,3},{1,4},{1,5}]
  #   answers = [2,4,6,8,10]
  #   m = length(points)
  #   alpha = 0.1
  #   # First theta
  #   index_0 = 0
  #   theta_0 = elem(thetas, index_0)
  #   assert update_theta(index_0, thetas, points, answers, alpha, m) != theta_0
  #   # Second theta
  #   index_1 = 1
  #   theta_1 = elem(thetas, index_1)
  #   assert update_theta(index_1, thetas, points, answers, alpha, m) != theta_1
  # end

  # test "run works properly" do
  #   points = [{1,1},{1,2},{1,3}]
  #   answers = [2,4,6]
  #   alpha = 0.1
  #   tolerance = 0.001
  #   assert run(points, answers, alpha, tolerance) == {0.6809901234567902, 1.6653922633744855}
  # end

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
end
