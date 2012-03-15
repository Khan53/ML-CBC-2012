function [ f_measures_per_fold ] = test10FoldDataCBR( data_type )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

[examples,targets] = loaddata(strcat(data_type,'data_students.txt'));

f_measures_per_fold = [];

for i = 0:9
    [trainSet, testSet] = split_dataset(i, examples, targets);
    cbr = CBRinit(trainSet.examples,trainSet.targets);

    conf_matrix_for_fold = create_confusion_matrix(testCBR(cbr, testSet.examples), testSet.targets);
    rp = calculate_recall_precision(conf_matrix_for_fold);
    f_measures_per_fold = horzcat(f_measures_per_fold, calculate_f_measure(rp,1));
end


end

