function [avgMatrix] = computeAverageMatrix(confusionMatrices)
    dim = ndims(confusionMatrices{1});
    M = cat(dim+1,confusionMatrices{:});
    avgMatrix = 10*mean(M,dim+1);