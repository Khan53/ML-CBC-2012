function [ cbr ] = CBRinit( examples, targets )

% Create a new CBR structure with 6 groups corresponding to the 6 emotions
% For each group, store the label of the emotion, list of cases and indices
% of AUs (combinations of AUs) that characterize the emotion.
cbr.groups = {};

for emotion=1:length(unique(targets))
    cbr.groups{emotion} = struct('label', emolab2str(emotion), ...
                                 'cases', [], ...
                                 'index', []);
end
                             
% Add all cases to the CBR system.
for row = 1:size(examples,1)
    newCase = CBR_newCase(examples(row,:), targets(row));
    cbr = retain(cbr, newCase);
end

end

