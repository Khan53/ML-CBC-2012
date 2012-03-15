oldFolder = cd ('Assignment 2')

f_measures_for_trees = testAllData()

cd(oldFolder)
oldFolder = cd ('Assignment3')

f_measures_for_NN = testAllDataNN()

cd(oldFolder)
oldFolder = cd ('Assignment 4')

f_measures_for_CBR = testAllDataCBR()

cd(oldFolder)



%%% Test the algorithms

[tTests, anovaTests_P, anovaTests_ANOVATAB, anovaTests_STATS, multiCompareTests] = ...
	  test_algorithms(f_measures_for_trees, f_measures_for_NN, f_measures_for_CBR);