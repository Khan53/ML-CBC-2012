function [avgMatrix] = computeAverageMatrix(confusionMatrices)
    %generates an average matrix out of several
    dim = ndims(confusionMatrices{1});
    M = cat(dim+1,confusionMatrices{:});
    avgMatrix = 10*mean(M,dim+1);