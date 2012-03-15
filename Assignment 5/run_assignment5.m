oldFolder = cd ('Assignment 2')

f_measures_for_trees = testAllData()
f_measures_for_trees_fold = test10FoldData('clean')

cd(oldFolder)
oldFolder = cd ('Assignment3')

%f_measures_for_NN = testAllDataNN()

cd(oldFolder)
oldFolder = cd ('Assignment 4')

%f_measures_for_CBR = testAllDataCBR()

cd(oldFolder)