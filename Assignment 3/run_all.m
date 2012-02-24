clear
%Add current directory and all subdirectories to MATLAB search path
addpath(genpath(pwd));
runs = 2;
%regenerate neural nets several times to account for randomness
confusionMatrices_multi = cell(1,runs);
confusionMatrices_single = cell(1,runs);
all_f_measures_multi = cell(1,runs);
all_f_measures_single = cell(1,runs);
for i = 1:runs
    [f_measures_multi, avgMatrix_multi] = run_multi_output;
    all_f_measures_multi{i} = f_measures_multi;
    confusionMatrices_multi{i} = avgMatrix_multi;
    [f_measures_single, avgMatrix_single] = run_single_output;
    all_f_measures_single{i} = f_measures_single;
    confusionMatrices_single{i} = avgMatrix_single;
end

avgMatrix = computeAverageMatrix(confusionMatrices_multi);
%calculate recall and precision
rp = calculate_recall_precision(avgMatrix);
%calculate f_measure
f_measure = calculate_f_measure(rp,1);
%plot confusion matrix
plot_confusion_matrix(avgMatrix);
%plot the variables
plot_stats(rp,f_measure);

avgMatrix = computeAverageMatrix(confusionMatrices_single);
%calculate recall and precision
rp = calculate_recall_precision(avgMatrix);
%calculate f_measure
f_measure = calculate_f_measure(rp,1);
%plot confusion matrix
plot_confusion_matrix(avgMatrix);
%plot the variables
plot_stats(rp,f_measure);

f_measures_multi = computeAverageFMeasure(all_f_measures_multi);
f_measures_single = computeAverageFMeasure(all_f_measures_single);

figure
plot([1:10], f_measures_multi);
hold on;
plot([1:10], f_measures_single, 'r');
title('F1 metric per fold');
xlabel('Fold');
ylabel('F1');
hleg = legend('Multi output net','Single output nets');
hold off;