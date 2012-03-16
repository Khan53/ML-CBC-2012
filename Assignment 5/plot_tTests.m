function [] = plot_tTests(t_tests)

dat = t_tests;
rcount = size(t_tests,1);
rnames = cell(rcount);
for i = 1:rcount,
    rnames{i} = emolab2str(i);
end


ccount = 3;
cnames = cell(ccount);
cnames{1} = 'DT vs NN';
cnames{2} = 'DT vs CBR';
cnames{3} = 'NN vs CBR';


f = figure('Position',[200 200 650 170]);
t = uitable('Parent', f,'Data',dat,'ColumnName',cnames,... 
            'RowName',rnames);
set(t, 'Position', [0 0 650 170]);
plot(t);


 