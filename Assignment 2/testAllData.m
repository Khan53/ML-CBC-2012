function [ f_measure ] = testAllData( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[trainExamples, trainTargets] = loaddata('cleandata_students.txt');
[testExamples, testTargets] = loaddata('noisydata_students.txt');

attribs = 1:45;
trees_of_emotions = cell(1,6);

%For each emotion, structure the target vector so that a '1' takes the place for an emotion
%and a '0' for the rest of the emotions. Then create the decision trees for each emotion.
for emotion = 1:6
    theEmotions{emotion} = remap_targets(trainTargets,emotion);
    trees_of_emotions{emotion} = decision_tree_learning(trainExamples,attribs,theEmotions{emotion});
end

predicted_targets_set = testTrees(trees_of_emotions, testExamples);

confusionMatrix = generate_confusion_matrix(predicted_targets_set, testTargets);
plot_confusion_matrix(confusionMatrix);

%calculate recall and precision
rp = calculate_recall_precision(confusionMatrix);

%calculate f_measure
f_measure = calculate_f_measure(rp,1);

end

