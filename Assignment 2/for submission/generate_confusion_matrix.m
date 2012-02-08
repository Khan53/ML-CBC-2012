function [confusionMatrix] = generate_confusion_matrix(predictions,actualTargets)
%GENERATE_CONFUSION_MATRIX - create confusion matrix to compare predicted classification of emotions
%				with respect to the actual targets.
%
%IN:  predictions: the predicted classifications of emotions for a 10 example slices of 10 [10 x 10]
%     actualTargets: the actual targets coming from the test data [10 x 10]
%OUT: confusionMatrix: resulting matrix describing the affect of our learner algorithm
  
  %Initializations
  noPredictions = size(predictions,1);  %This should be 10, for our slices have 10 examples.
  rownum = max(max(actualTargets)); %Range of emotions in actual targets
  colnum = max(max(predictions)); %Range of emotions in predicted targets
  confusionMatrix = zeros(rownum, colnum); %Constructs confusion matrix  for N emotions

[numRowsPredicted, numColsPredicted] = size(predictions);
for i = 1:numColsPredicted
    for j=1:numRowsPredicted
        confusionMatrix(actualTargets(j, i), predictions(j, i)) ...
        = confusionMatrix(actualTargets(j, i), predictions(j, i)) + 1;
    end
end
end
