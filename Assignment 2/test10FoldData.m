function [ f_measures_per_fold ] = test10FoldData( data_type )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

attribs = 1:45;

[examples,targets] = loaddata( strcat(data_type,'data_students.txt'));


%Start evaluating the learning algorithm using ten-fold cross validation.
%predicted emotion labels (targets) from testSets 10x10, where each column
%is a different test.
predicted_targets_set = [];
%given target labels for each test set
actual_targets_set = [];
trees_of_emotions = cell(1,6);
f_measures_per_fold = [];

for i = 0:9
    [trainSet, testSet] = split_dataset(i, examples, targets);
    %For each emotion, structure the target vector so that a '1' takes the place for an emotion
    %and a '0' for the rest of the emotions. Then create the decision trees for each emotion.
    for emotion = 1:6
        theEmotions{emotion} = remap_targets(trainSet.targets,emotion);
        trees_of_emotions{emotion} = decision_tree_learning(trainSet.examples,attribs,theEmotions{emotion});
    end
    predictions = testTrees(trees_of_emotions, testSet.examples);
    predicted_targets_set = cat(2,predicted_targets_set,predictions); %adds a column for each example
    actual_targets_set = cat(2,actual_targets_set,testSet.targets); %adds a column for the target's matrix
    
    confMatrixFold = generate_confusion_matrix(predictions, testSet.targets);

    rp = calculate_recall_precision(confMatrixFold);
    f_measures_per_fold = horzcat(f_measures_per_fold, calculate_f_measure(rp,1));
end

end

