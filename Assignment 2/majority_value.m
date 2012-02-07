function [majorityValue] = majority_value(targets)
%MAJORITY_VALUE - returns the majority value of the example goals
%
%IN:  targets:	target labels for the training examples [N x 1]
%OUT: maj_val:	resulting value most frequent in 'targets'
  majorityValue = mode(targets);		%Using mode returns the element appearing most frequently
end
