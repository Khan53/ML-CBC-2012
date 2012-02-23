function [ trainSet, testSet ] = split_dataset( i, examples, targets )
%SPLIT_DATASET - Splits the dataset in train and test data.
%
%IN:  i - counter from using ten-fold cross validation, values from 0 to 9 taken
%     examples - set of training examples with X columns less than or equal to 45
%     targets -	target labels for the training examples
%OUT: trainSet - 90% of the set of training examples and associated target labels
%     testSet -	10% of the set of training examples and associated target labels
range = length(targets);
interval = range/10;

firstTestSample = i*interval + 1;
lastTestSample = firstTestSample + interval - 1;

testSet.examples = examples(firstTestSample:lastTestSample, :);
testSet.targets = targets(firstTestSample:lastTestSample);

examples(firstTestSample:lastTestSample, :) = [];
targets(firstTestSample:lastTestSample) = [];

trainSet.examples = examples;
trainSet.targets = targets;
end

