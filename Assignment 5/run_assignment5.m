oldFolder = cd ('Assignment 2')

f_measures_for_trees = testAllData();
f_measures_for_trees_fold_clean = test10FoldData('clean');
f_measures_for_trees_fold_noisy = test10FoldData('noisy');

cd(oldFolder)
oldFolder = cd ('Assignment3')

f_measures_for_NN = testAllDataNN();
f_measures_for_NN_fold_clean = test10FoldDataNN('clean');
f_measures_for_NN_fold_noisy = test10FoldDataNN('noisy');

cd(oldFolder)
oldFolder = cd ('Assignment 4')

f_measures_for_CBR = testAllDataCBR();
f_measures_for_CBR_fold_clean = test10FoldDataCBR('clean');
f_measures_for_CBR_fold_noisy = test10FoldDataCBR('noisy');

cd(oldFolder)

%Test the algorithms
[tTests, anovaTests_P, anovaTests_ANOVATAB, anovaTests_STATS, multiCompareTests] = ...
    test_algorithms(f_measures_for_trees_fold_clean, ...
                    f_measures_for_NN_fold_clean, ...
                    f_measures_for_CBR_fold_clean);

 
plot_f_averages(f_measures_for_trees,f_measures_for_NN,f_measures_for_CBR)