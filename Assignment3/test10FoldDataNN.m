function [ f_measures_per_fold ] = test10FoldDataNN( data_type )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

[examples,targets] = loaddata(strcat(data_type, 'data_students.txt'));

f_measures_per_fold = cell(1, 10);

%Performs 10-fold cross validation
for i = 0:9
    [trainSet, testSet] = split_dataset(i, examples, targets);

    %Transform data 
    [trainSet.examples, trainSet.targets] = ANNdata(trainSet.examples, trainSet.targets);    

    %Builds one six output neural nets
    neuralNet = buildMultipleOutputNeuralNet(trainSet.examples, trainSet.targets, 'regularization');

    %Uses the trained nets to classify examples in the test set
    predictions = testANN(neuralNet, testSet);
    confMatrix = create_confusion_matrix(predictions, testSet.targets);

    %calculate recall and precision for this fold
    rp = calculate_recall_precision(confMatrix);
    %calculate f_measure for this fold, averaging across all classes
    %(emotions)
    f_measures_per_fold{i+1} = calculate_f_measure(rp,1);
end

end

