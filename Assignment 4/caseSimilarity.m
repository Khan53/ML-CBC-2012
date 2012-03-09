function [ similarity ] = caseSimilarity( caseOne, caseTwo )
% Computes a measure of how similar two cases are.
% The negative signs suggest that the higher the similarity
% value is, the more similar the two cases are.

% the measure we currently use for the CBR system
similarityMeasure = 'jaccard';

if(strcmp(similarityMeasure, 'default') == 1)
    % Length of the vectors describing the problem descriptions
    lengthOne = size(caseOne.problem, 2);
    lengthTwo = size(caseTwo.problem, 2);
    similarity = -abs(lengthOne - lengthTwo);
    
elseif(strcmp(similarityMeasure, 'l1_norm') == 1)
    % The manhattan distance. Setxor takes unique elements that are not in the
    % intersection of the two cases. We take the length of that.
    similarity = -length(setxor(caseOne.problem, caseTwo.problem));
    
elseif(strcmp(similarityMeasure, 'l2_norm') == 1)
    % The euclidean distance is simply taking the square root of the manhattan.
    similarity = -sqrt(length(setxor(caseOne.problem, caseTwo.problem)));
elseif(strcmp(similarityMeasure, 'jaccard') == 1)
    intersectionOfProblems = intersect(caseOne.problem, caseTwo.problem) ;
    unionOfProblems = union(caseOne.problem, caseTwo.problem) ;
    similarity = length(intersectionOfProblems) / length(unionOfProblems);
end
