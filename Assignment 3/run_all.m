clear
%Add current directory and all subdirectories to MATLAB search path
addpath(genpath(pwd));

f_measures_multi = run_multi_output;
f_measures_single = run_single_output;
plot([1:10], f_measures_multi);
plot([1:10], f_measures_single, 'r');