clear
%Add current directory and all subdirectories to MATLAB search path
addpath(genpath(pwd));


%Load data for assignment 3 - Artificial Neural Networks
%examples - Nx45 array of AUs present for each example
%targets - Nx1 array of an emotion (1-6) represented for each example
[examples,targets] = loaddata('cleandata_students.txt');

confusionMatrices = cell(1,10);
for i = 0:9
    [trainSet, testSet] = split_dataset(i, examples, targets);

    %Transform data 
    [trainSet.examples, trainSet.targets] = ANNdata(trainSet.examples, trainSet.targets);    
    %[testSet.examples, testSet.targets] = ANNdata(testSet.examples, testSet.targets);    
    neuralNets = buildSingleOutputNeuralNets(trainSet.examples, trainSet.targets);
    
    %predictions = [];
    classifications = zeros(10, 1);
    for index=1:10
        networkClassifications = zeros(6, 1);
        example = testSet.examples(index, :)';
        for emotion = 1:6
            networkClassifications(emotion) = sim(neuralNets{emotion}, example);
            %predictions = cat(2,predictions, testANN(neuralNets(emotion).net, testSet.examples')); 
        end
        classifications(index) = NNout2labels(networkClassifications);
    end 
    confusionMatrices{(i+1)} = create_confusion_matrix(classifications, testSet.targets);
end

avgMatrix = computeAverageMatrix(confusionMatrices);
%calculate recall and precision
rp = calculate_recall_precision(avgMatrix);
%calculate f_measure
f_measure = calculate_f_measure(rp,1);
%plot the variables
plot_stats(rp,f_measure);

