function [ trainSet, testSet ] = split_dataset( i, examples, targets )
%SPLIT_DATASET - Splits the dataset in train and test data. 
%   Detailed explanation goes here
range = length(targets);
interval = range/10;

firstTestSample = i*interval + 1
lastTestSample = firstTestSample + interval - 1

testSet.examples = examples(firstTestSample:lastTestSample, :);
testSet.targets = targets(firstTestSample:lastTestSample);

examples(firstTestSample:lastTestSample, :) = [];
targets(firstTestSample:lastTestSample) = [];

trainSet.examples = examples;
trainSet.targets = targets;
end

