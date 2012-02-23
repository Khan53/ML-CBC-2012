clear
%Add current directory and all subdirectories to MATLAB search path
addpath(genpath(pwd));

f_measures_multi = run_multi_output;
f_measures_single = run_single_output;
figure
plot([1:10], f_measures_multi);
hold on;
plot([1:10], f_measures_single, 'r');
title('F1 metric per fold');
xlabel('Fold');
ylabel('F1');
hleg = legend('Multi output net','Single output nets');
hold off;