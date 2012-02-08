function [ y ] = testTrees( T, x )
% This function takes as inputs the decsion trees for each emotion and the 
% set of test data. Firstly, it iterates over all the examples in the test 
% set and for each one it calls the classify_example method. It recursively
% parses each one of the trees and it finds the prediction of each binary 
% classifier. The end result is a vector of the individual predictions of 
% each classifier. In order to combine the results we call the pickOneEmotion
% method which is then responsible to select one of the positive results in
% the vector. If a tie or an ambiguity occured then this function employs one 
% of two methods to resolve them. These methods are explained in detail in 
% the comments of that function. 

noExamples = size(x,1);
y = zeros(noExamples, 1);
for example=1:noExamples
    predictions = zeros(6, 1);
    depth = zeros(6, 1);
    for emotion = 1:6
        [depth(emotion), predictions(emotion)] = classify_example( T{emotion}, x(example, :), 0);
    end
    y(example) = pickOneEmotion(predictions, depth);
end

function [ depth, prediction ] = classify_example( T, example, depth )
% This function recursively parses the decision tree until it reaches a
% leaf node. The class of that node is the prediction for this specific
% example. Each time we descend in the tree we increase a depth measure
% which is used later to resolve ambiguities.

if (isempty(T.kids))
    prediction = T.class;
    depth = depth;
else
    if (example(T.op) == 0)
        [depth, prediction] = classify_example(T.kids{1}, example, depth+1);
    else
        [depth, prediction] = classify_example(T.kids{2}, example, depth+1);
    end
end

function [ singleEmotion ] = pickOneEmotion( predictions, depth )
% This function is responsible for combining the results of the binary
% classifiers for an example. If only one positive prediction occured then
% we can safely assign the predicted class to the example. However, there
% are cases where no prediction or multiple predictions have been assigned
% to this example. In these cases we use two different methods to resolve
% ambiguities. The first one picks an emotion in random and the other one
% assigns the class with the deepest emotion matched with our example. By
% default we use the deepest technique but you can comment out that line
% and uncomment the one using the random method to comapre the results. 
emotionIndex = find(predictions == 1);
if (length(emotionIndex) == 1) 
    singleEmotion = emotionIndex;
elseif (length(emotionIndex) > 0) %If more than one emotions have been assigned
    positiveDepth = [];
    for i =1:length(emotionIndex)
        positiveDepth = [positiveDepth depth(emotionIndex(i))];
    end
    %singleEmotion = pickDeepest(positiveDepth);
    singleEmotion = pickRandom(emotionIndex);
else
    %singleEmotion = pickDeepest(depth);
    singleEmotion = pickRandom(find(predictions == 0));
end

function [randomIndex] = pickRandom(predictions)
% Picks a random emotion from the predicted ones.
range = length(predictions);
randomNo = randi(range, 1);
randomIndex = predictions(randomNo);

function [deepestEmotion] = pickDeepest(depth)
% Picks the deepest matched emotion from the predicted ones.
[~, deepestEmotion] = max(depth(:)); 
