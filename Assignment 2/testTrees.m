function [ y ] = testTrees( T, x )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

noExamples = size(x,1);
for example=1:noExamples
    predictions = zeros(6, 1);
    for emotion = 1:6
        predictions(emotion) = classify_example( T{emotion}, x(example, :));
    end
    x(example, :)
    y = predictions
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

