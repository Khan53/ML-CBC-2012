function [] = plot_confusion_matrix(confusion_matrix)


dat = confusion_matrix;
rcount = size(confusion_matrix,1);
rnames = cell(rcount);
for i = 1:rcount,
    rnames{i} = emolab2str(i);
end
ccount = size(confusion_matrix,2);
cnames = cell(ccount);
for i = 1:ccount,
    cnames{i} = emolab2str(i);
end

f = figure('Position',[200 200 650 170]);
t = uitable('Parent', f,'Data',dat,'ColumnName',cnames,... 
            'RowName',rnames);
set(t, 'Position', [0 0 650 170]);
plot(t);