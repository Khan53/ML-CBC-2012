function[] = plot_stats(rp,f_measure);

dat = cat(2,rp,f_measure)

rcount = size(rp,1);
rnames = cell(rcount);
for i = 1:rcount,
    rnames{i} = emolab2str(i);
end

cnames = {'Recall','Precision','F-Measure'};
f = figure('Position',[200 200 650 170]);
t = uitable('Parent', f,'Data',dat,'ColumnName',cnames,... 
            'RowName',rnames);
set(t, 'Position', [0 0 650 170]);
plot(t);