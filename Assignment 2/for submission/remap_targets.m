function [targets] = remap_targets(targets,emotion)
%REMAP_TARGETS - The 'targets' vector is restructured so that a '1' is being held
%		 for a particular emotion and '0' everywhere else.
%
%IN:  targets: target labels for the training examples [N x 1]
%     emotion: the emotion (as a number) we want to restructure the target vector into
%OUT: targets: targets vector after some manipulations

  targets(targets ~= emotion) = 0;
  targets(targets == emotion) = 1;
end