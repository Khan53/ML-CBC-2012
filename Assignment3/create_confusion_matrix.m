function [ matrix ] = create_confusion_matrix(predictions, targets)
%Transform targets into emotion indices
[rows, cols] = size(predictions);
matrix = zeros(6,6);
%produces confusion matrix
for i = 1:rows
    row = predictions(i,1);
    col = targets(i,1);
    matrix(row,col) = matrix(row,col) + 1;
end
end
