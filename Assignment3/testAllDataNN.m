function [ f_measures ] = testAllDataNN( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[trainExamples,trainTargets] = loaddata('cleandata_students.txt');
[testExamples,testTargets] = loaddata('noisydata_students.txt');

testSet.examples = testExamples;
testSet.targets = testTargets;

%Transforms data
[trainExamples, trainTargets] = ANNdata(trainExamples, trainTargets);    
%Builds six single output neural nets
neuralNets = buildMultipleOutputNeuralNet(trainExamples, trainTargets, 'regularization');

%Uses the trained nets to classify examples in the test set
predictions = testANN(neuralNets, testSet);
confusionMatrix = create_confusion_matrix(predictions, testSet.targets);
plot_confusion_matrix(confusionMatrix);
%calculate recall and precision for this fold
rp = calculate_recall_precision(confusionMatrix);

f_measures = calculate_f_measure(rp,1);

end

