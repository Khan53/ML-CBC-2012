function [ f_measures ] = testAllDataCBR(  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[trainExamples,trainTargets] = loaddata('cleandata_students.txt');
[testExamples, testTargets] = loaddata('noisydata_students.txt');

cbr = CBRinit(trainExamples, trainTargets);

%Code to caclulate F measure per fold
conf_matrix = create_confusion_matrix(testCBR(cbr, testExamples), testTargets);
plot_confusion_matrix(conf_matrix);
rp = calculate_recall_precision(conf_matrix);
f_measures = calculate_f_measure(rp,1);
   
end

