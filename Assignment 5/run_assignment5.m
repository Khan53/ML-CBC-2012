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
[tTests_clean, anovaTests_P_clean, anovaTests_ANOVATAB_clean, anovaTests_STATS_clean, multiCompareTests_clean] = ...
    test_algorithms(f_measures_for_trees_fold_clean, ...
                    f_measures_for_NN_fold_clean, ...
                    f_measures_for_CBR_fold_clean);

[tTests_noisy, anovaTests_P_noisy, anovaTests_ANOVATAB_noisy, anovaTests_STATS_noisy, multiCompareTests_noisy] = ...
    test_algorithms(f_measures_for_trees_fold_noisy, ...
                    f_measures_for_NN_fold_noisy, ...
                    f_measures_for_CBR_fold_noisy);


plot_f_measure_averages(f_measures_for_trees,f_measures_for_NN,f_measures_for_CBR);

plot_f_measure_averages_fold(f_measures_for_trees_fold_clean,f_measures_for_NN_fold_clean,f_measures_for_CBR_fold_clean);
plot_f_measure_averages_fold(f_measures_for_trees_fold_noisy,f_measures_for_NN_fold_noisy,f_measures_for_CBR_fold_noisy);

plot_tTests(tTests_clean);
plot_tTests(tTests_noisy);

plot_anovaTests(anovaTests_P_clean);
plot_anovaTests(anovaTests_P_noisy);