function [ solvedCase ] = reuse( bestKnownCase, newCase )
% The new case brings the same problem as an existing case. We attach the
% solution of the known case to this new case, resulting in a solved case.

solvedCase = newCase;
solvedCase.solution = bestKnownCase.solution;

end
