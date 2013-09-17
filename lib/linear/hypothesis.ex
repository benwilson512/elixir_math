defrecord Math.Linear.Hypothesis, parameters: [], features: [] do

  def create(features, val // 0) do
    features = [1 | features]
    parameters = lc x inlist features, do: 0
    Math.Linear.Hypothesis.new parameters: parameters, features: features
  end

  def t(point, hypothesis) do
    hypothesis.parameters |> Math.vector_product(hypothesis.features)
  end
end
