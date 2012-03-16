function [] = plot_f_averages_fold(pValues)

dat = pValues;

rnames = 'P-Value';

ccount = 6;
cnames = cell(ccount);
for i = 1:ccount,
    cnames{i} = emolab2str(i);
end


f = figure('Position',[200 200 650 170]);
t = uitable('Parent', f,'Data',dat,'ColumnName',cnames,... 
            'RowName',rnames);
set(t, 'Position', [0 0 650 170]);

plot(t);



 