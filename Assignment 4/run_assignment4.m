clear
%Add current directory and all subdirectories to MATLAB search path
addpath(genpath(pwd));


%Load data for assignment 4 - Case Based Reasoning
%examples - Nx45 array of AUs present for each example
%targets - Nx1 array of an emotion (1-6) represented for each example
[examples,targets] = loaddata('cleandata_students.txt');

%Initialise the CBR structure
cbr = CBRinit(examples,targets);

save CBR cbr;

n = 10;
confusionMatrices = cell(1, 10);
for turn=1:n
    %Start evaluating the learning algorithm using ten-fold cross validation.
    %predicted emotion labels (targets) from testSets 10x10, where each column
    %is a different test.
    predicted_targets_set = [];
    %given target labels for each test set
    actual_targets_set = [];
    emotions = cell(1,6);
    f_measures = zeros(10, 1);

    for i = 0:9
        [trainSet, testSet] = split_dataset(i, examples, targets);
        cbr = CBRinit(trainSet.examples,trainSet.targets);

        predicted_targets_set = cat(2,predicted_targets_set,testCBR(cbr, testSet.examples)); %adds a column for each example
        actual_targets_set = cat(2,actual_targets_set,testSet.targets); %adds a column for the target's matrix
        
        %Code to caclulate F measure per fold
        conf_matrix_for_fold = create_confusion_matrix(testCBR(cbr, testSet.examples), testSet.targets);
        rp = calculate_recall_precision(conf_matrix_for_fold);
        f_measures(i+1, 1) = mean(calculate_f_measure(rp,1));
    end
    %calculate and plot confusion matrix
    confusionMatrix = generate_confusion_matrix(predicted_targets_set, actual_targets_set);
    confusionMatrices{turn} = confusionMatrix;
    
    plot([1:10], f_measures, 'r');
    title('F-measure per fold');
    xlabel('Fold');
    ylabel('F1');
    
end
averageConfusionMatrix = computeAverageMatrix(confusionMatrices);   
plot_confusion_matrix(averageConfusionMatrix);

%calculate recall and precision
rp = calculate_recall_precision(averageConfusionMatrix);
%calculate f_measure
f_measure = calculate_f_measure(rp,1);
%plot the variables
plot_stats(rp,f_measure);


