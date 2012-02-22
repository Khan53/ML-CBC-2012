function [ matrix ] = create_confusion_matrix(predictions, targets)
%Transform targets into emotion indices
for i=1:size(targets, 1)
    targets(i, :) = NNout2labels(targets(i, :));
end  
targets
[rows, cols] = size(predictions);
matrix = zeros(6,6);

for i = 1:rows
    row = predictions(i,1);
    col = targets(i,1);
    
    if(row == col)
        row = col;
    end;
    matrix(row,col) = matrix(row,col) + 1;
end
end
