function [ newCase ] = CBR_newCase( example, target )

% Looking for indices holding non-zero values
index_active_AUs = find(example);

% Construct a new case with typicality being the number of times
% the same case is found.
newCase = struct('problem', index_active_AUs, ... 
                 'solution', target, ...
                 'typicality', 0);

end

