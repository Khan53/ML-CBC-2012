%Add current directory and all subdirectories to MATLAB search path
addpath(genpath(pwd));


%Load data for assignment 2 - Decision Trees
attribs = 1:45;
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
y = [];
for i = 0:9
    [trainSet, testSet] = split_dataset(i, examples, targets);
    for emotion = 1:6
        theEmotions{emotion} = remap_targets(trainSet.targets,emotion);
        trees_of_emotions{emotion} = decision_tree_learning(trainSet.examples,attribs,theEmotions{emotion});
	%DrawDecisionTree(trees_of_emotions{emotion},emolab2str(emotion));
    end
    y = cat(2,y,testTrees(trees_of_emotions, testSet.examples)); %adds a column for each example
end
testSet.targets
y
confusionMatrix = generate_confusion_matrix(y,testSet.targets)


