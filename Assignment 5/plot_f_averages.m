function [] = plot_f_averages(DT_fMeasures,NN_fMeasures,CBR_fMeasures)

DT = [DT_fMeasures; mean(DT_fMeasures)];
NN = [NN_fMeasures; mean(NN_fMeasures)];
CBR = [CBR_fMeasures; mean(CBR_fMeasures)];


dat = cat(2,DT,NN,CBR);
rcount = size(DT,1);
rnames = cell(rcount);
for i = 1:rcount-1,
    rnames{i} = emolab2str(i);
end
rnames{rcount} = 'Average';


ccount = 3;
cnames = cell(ccount);
cnames{1} = 'Decision-Trees';
cnames{2} = 'Neural-Networks';
cnames{3} = 'Case-Based-Reasoning';


f = figure('Position',[200 200 650 170]);
t = uitable('Parent', f,'Data',dat,'ColumnName',cnames,... 
            'RowName',rnames);
set(t, 'Position', [0 0 650 170]);
plot(t);


 