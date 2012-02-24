function [f_measures,avgMatrix] = run_multi_output()
    clear
    %Add current directory and all subdirectories to MATLAB search path
    addpath(genpath(pwd));


    %Load data for assignment 3 - Artificial Neural Networks
    %examples - Nx45 array of AUs present for each example
    %targets - Nx1 array of an emotion (1-6) represented for each example
    [examples,targets] = loaddata('cleandata_students.txt');

    %examples and targets transformed for neural nets
    [P,T] = ANNdata(examples,targets);

    [noExamples, ~] = size(examples);
    confusionMatrices = cell(1,noExamples);
    f_measures = zeros(noExamples/10, 1);
    
    %Performs 10-fold cross validation
    for i = 0:9
        [trainSet, testSet] = split_dataset(i, examples, targets);

        %Transform data 
        [trainSet.examples, trainSet.targets] = ANNdata(trainSet.examples, trainSet.targets);    
        
        %Builds one six output neural nets
        neuralNet = buildMultipleOutputNeuralNet(trainSet.examples, trainSet.targets, 'regularization');
        
        %Uses the trained nets to classify examples in the test set
        predictions = testANN(neuralNet, testSet);
        confusionMatrices{(i+1)} = create_confusion_matrix(predictions, testSet.targets);

        %calculate recall and precision for this fold
        rp = calculate_recall_precision(confusionMatrices{(i+1)});
        %calculate f_measure for this fold, averaging across all classes
        %(emotions)
        f_measures(i+1, 1) = mean(calculate_f_measure(rp,1));
    end

    avgMatrix = computeAverageMatrix(confusionMatrices);
    
end

