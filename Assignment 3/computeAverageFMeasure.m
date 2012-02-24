function [avgMatrix] = computeAverageFMeasure(confusionMatrices)
    %computes the confusion matrix of all runs
    dim = ndims(confusionMatrices{1});
    M = cat(dim+1,confusionMatrices{:});
    avgMatrix = avg(M,dim+1);
    