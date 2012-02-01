function [majorityValue] = majority_value(targets)
%MAJORITY_VALUE - returns the majority value of the example goals
%
% AUTHOR:	A. Khan, G. Eracleous, G. Jones, V. Kriauciukas
% CREATED:	31012012
%
%IN:  targets:	target labels for the training examples [N x 1]
%OUT: maj_val:	resulting value most frequent in 'targets'

  majorityValue = mode(targets);		%mode returns the element appeariing most frequently
end
