function [avgMatrix] = computeAverageMatrix(confusionMatrices)
    %computes the confusion matrix of all runs
    dim = ndims(confusionMatrices{1});
    M = cat(dim+1,confusionMatrices{:});
    avgMatrix = sum(M,dim+1);
    