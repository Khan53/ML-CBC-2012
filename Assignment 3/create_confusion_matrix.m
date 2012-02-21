function [ matrix ] = create_confusion_matrix(predictions, targets)
predictions
targets
%Transform targets into emotion indices
for i=1:size(targets, 1)
    targets(i, :) = NNout2labels(targets(i, :));
end
targets    

[N, M] = size(predictions);
matrix = zeros(6,6);

for i = 1:N
    row = predictions(i,1);
    column = targets(i,1);
    
    if(row == column)
        row = column;
    end;
    matrix(row,column) = matrix(row,column) + 1;
end
end
