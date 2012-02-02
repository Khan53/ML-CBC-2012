function [confusionMatrix] = generate_confusion_matrix(predictions,actualTargets)
%GENERATE_CONFUSION_MATRIX - create confusion matrix to compare predicted classification of emotions
%				with respect to the actual targets.
%
%IN:  predictions: the predicted classifications of emotions [6 x 10]
%     actualTargets: the actual targets coming from the test data [6 x 1]
%OUT: confusionMatrix: resulting matrix describing the affect of our learner algorithm
  
  %Initializations
  noPredictions = size(predictions,1);				%This should be 6, for our task has 6 emotions.
  confusionMatrix = zeros(6, 6);	%The 6 x 6 matrix to construct

  %For each of our examples,
  %atain the emotion that is accurate,
  %populate the confusion matrix in dependence of matching an accurate emotion to the predicted.
%   for index = 1:length(actualTargets)
%     actualEmotion = actualTargets(index);
%     if (predictions(actualEmotion,index) == 1)
%       confusionMatrix(actualEmotion,actualEmotion) = confusionMatrix(actualEmotion,actualEmotion) + 1;
%     else
%       predictedEmotion = find(predictions(:,index) == 1);	%the predicted emotion
%       confusionMatrix(actualEmotion,predictedEmotion) = confusionMatrix(actualEmotion,predictedEmotion) + 1;
%     end
%   end
[numRowsPredicted, numColsPredicted] = size(predictions);
for i = 1:numColsPredicted
    for j=1:numRowsPredicted
        confusionMatrix(actualTargets(j, i), predictions(j, i)) ...
        = confusionMatrix(actualTargets(j, i), predictions(j, i)) + 1;
    end
end
end
