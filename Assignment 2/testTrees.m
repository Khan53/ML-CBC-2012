function [ y ] = testTrees( T, x )
%TESTTREE  Summary of this function goes here
%   Detailed explanation goes here
%IN:  T: 6 decision trees
%     x: sparse, binary featureset of aus [N x 45]
%OUT: y: emotion labels

noExamples = size(x,1);
y = zeros(noExamples, 1);
for example=1:noExamples
    predictions = zeros(6, 1);
    for emotion = 1:6
        predictions(emotion) = classify_example( T{emotion}, x(example, :));
    end
    emotionIndex = find(predictions == 1, 1, 'first');
    
    %The following lines of code MUST BE changed. For now
    %assume that if this example is unclassified then assign 
    %it a defualt emotion i.e. emotion = 1. 
    if (length(emotionIndex)>0)
        y(example) = emotionIndex;
    else
        y(example) = 1;
    end
end


function [ prediction ] = classify_example( T, example )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if (isempty(T.kids))
    prediction = T.class;
else
    if (example(T.op) == 0)
        prediction = classify_example(T.kids{1}, example);
    else
        prediction = classify_example(T.kids{2}, example);
    end
end

