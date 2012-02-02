%Add current directory and all subdirectories to MATLAB search path
addpath(genpath(pwd));


%Load data for assignment 2 - Decision Trees
attribs = 1:45;
[examples,targets] = loaddata('cleandata_students.txt');


%Start creating the trees for each of the 6 emotions
%WOULD IT BE BETTER TO HAVE THIS NEXT BLOCK EMBEDDED INTO THE DECISION TREE ALGORITHM?
theEmotions = cell(1,6);
%For each emotion, structure the target vector so that a '1' takes the place for an emotion
%and a '0' for the rest of the emotions.
for emotion = 1:6
  theEmotions{emotion} = remap_targets(targets,emotion);
end


trees_of_emotions = cell(1,6);
%Create the decision trees for each emotion.
for emotion = 1:6
  trees_of_emotions{emotion} = decision_tree_learning(examples,attribs,theEmotions{emotion});
  DrawDecisionTree(trees_of_emotions{emotion},emolab2str(emotion));
end

%Start evaluating the learning algorithm using ten-fold cross validation.
for i = 0:9:
    [trainSet, testSet] = split_dataset(i, examples, targets)
end