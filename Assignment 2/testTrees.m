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
    depth = zeros(6, 1);
    for emotion = 1:6
        [depth(emotion), predictions(emotion)] = classify_example( T{emotion}, x(example, :), 0);
    end
    
    emotionIndex = find(predictions == 1);
    if (length(emotionIndex) == 1) 
        y(example) = emotionIndex;
    elseif (length(emotionIndex) > 0) %If more than one emotions have been assigned
        [~, deepestEmotion] = max(depth(:)); 
        y(example) = deepestEmotion;
    else
        [~, deepestEmotion] = max(depth(:)); 
        y(example) = deepestEmotion;
    end
end


function [ depth, prediction ] = classify_example( T, example, depth )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if (isempty(T.kids))
    prediction = T.class;
    depth = 1;
else
    [depth, prediction] = classify_example(T.kids{example(T.op) + 1}, example, depth+1);
end

