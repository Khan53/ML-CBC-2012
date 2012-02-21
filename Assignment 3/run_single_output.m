clear
%Add current directory and all subdirectories to MATLAB search path
addpath(genpath(pwd));


%Load data for assignment 3 - Artificial Neural Networks
%examples - Nx45 array of AUs present for each example
%targets - Nx1 array of an emotion (1-6) represented for each example
[examples,targets] = loaddata('cleandata_students.txt');

%examples and targets transformed for neural nets
[P,T] = ANNdata(examples,targets);

for i = 0:9
    [trainSet, testSet] = split_dataset(i, examples, targets);

    %Transform data 
    [trainSet.examples, trainSet.targets] = ANNdata(trainSet.examples, trainSet.targets);    
    [testSet.examples, testSet.targets] = ANNdata(testSet.examples, testSet.targets);    
    neuralNets = buildSingleOutputNeuralNets(trainSet.examples, trainSet.targets);
    
    classifications = testBinaryNetworks(neuralsNets, testData);
end

