function [targets] = remap_targets(targets,emotion)
%REMAP_TRAGETS - The 'targets' vector is restructured so that a '1' is being held
%		 for a particular emotion and '0' everywhere else.
%
% AUTHOR:	A. Khan, G. Eracleous, G. Jones, V. Kriauciukas
% CREATED:	31012012
%
%IN:  targets: target labels for the training examples [N x 1]
%     emotion: the emotion (as a number) we want to restructure the target vector into
%OUT: targets: targets vector after some manipulations

  targets(targets ~= emotion) = 0;
  targets(targets == emotion) = 1;
end