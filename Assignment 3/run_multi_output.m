function [f_measures] = run_multi_output()
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
    for i = 0:9
        [trainSet, testSet] = split_dataset(i, examples, targets);

        %Transform data 
        [trainSet.examples, trainSet.targets] = ANNdata(trainSet.examples, trainSet.targets);    
        neuralNet = buildMultipleOutputNeuralNet(trainSet.examples, trainSet.targets, 'earlystop');

        predictions = testANN(neuralNet, testSet);
        confusionMatrices{(i+1)} = create_confusion_matrix(predictions, testSet.targets);

        %calculate recall and precision for this fold
        rp = calculate_recall_precision(confusionMatrices{(i+1)});
        %calculate f_measure for this fold
        f_measures(i+1, 1) = mean(calculate_f_measure(rp,1));
    end

    avgMatrix = computeAverageMatrix(confusionMatrices);
    %calculate recall and precision
    rp = calculate_recall_precision(avgMatrix);
    %calculate f_measure
    f_measure = calculate_f_measure(rp,1);
    %plot the variables
    plot_stats(rp,f_measure);
    
end

