clear
%Add current directory and all subdirectories to MATLAB search path
addpath(genpath(pwd));


%Load data for assignment 2 - Decision Trees
attribs = 1:45;
%examples - Nx45 array of AUs present for each example
%targets - Nx1 array of an emotion (1-6) represented for each example
[examples,targets] = loaddata('cleandata_students.txt');


%Start creating the trees for each of the 6 emotions
theEmotions = cell(1,6);
trees_of_emotion = cell(1,6);
%For each emotion, structure the target vector so that a '1' takes the place for an emotion
%and a '0' for the rest of the emotions. Then create the decision trees for each emotion.
for emotion = 1:6
  theEmotions{emotion} = remap_targets(targets,emotion);
  trees_of_emotion{emotion} = decision_tree_learning(examples,attribs,theEmotions{emotion});
  %DrawDecisionTree(trees_of_emotion{emotion},emolab2str(emotion));
end

%Start evaluating the learning algorithm using ten-fold cross validation.
% predicted emotion labels (targets) from testSets 10x10, where each column
%is a different test.
predicted_targets_set = [];
%given target labels for each test set (organised as y above)
actual_targets_set = [];
for i = 0:9
    [trainSet, testSet] = split_dataset(i, examples, targets);
    for emotion = 1:6
        theEmotions{emotion} = remap_targets(trainSet.targets,emotion);
        trees_of_emotions{emotion} = decision_tree_learning(trainSet.examples,attribs,theEmotions{emotion});
	%DrawDecisionTree(trees_of_emotions{emotion},emolab2str(emotion));
    end
    predicted_targets_set = cat(2,predicted_targets_set,testTrees(trees_of_emotions, testSet.examples)); %adds a column for each example
    actual_targets_set = cat(2,actual_targets_set,testSet.targets); %adds a column for the target's matrix
end
confusionMatrix = generate_confusion_matrix(predicted_targets_set,actual_targets_set);
%plot the matrix
plot_confusion_matrix(confusionMatrix);
%calculate recall and precision
rp = calculate_recall_precision(confusionMatrix);
%calculate f_measure
f_measure = calculate_f_measure(rp,1);
%plot the variables
plot_stats(rp,f_measure);
