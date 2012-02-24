function [avgMatrix] = computeAverage(confusionMatrices)
    %computes the confusion matrix of all runs
    dim = ndims(confusionMatrices{1});
    M = cat(dim+1,confusionMatrices{:});
    avgMatrix = mean(M,dim+1);
    