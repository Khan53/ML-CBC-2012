function [y] = testANN(network, examples)

  t = sim(network, examples);
  [y] = NNout2labels(t);