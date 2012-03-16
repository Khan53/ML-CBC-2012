function [] = plot_f_averages_fold(DT_fMeasures,NN_fMeasures,CBR_fMeasures)

DT = [DT_fMeasures'; mean(DT_fMeasures')];
NN = [NN_fMeasures'; mean(NN_fMeasures')];
CBR = [CBR_fMeasures'; mean(CBR_fMeasures')];


dat = cell(1,3);
dat{1} = DT;
dat{2} = NN;
dat{3} = CBR;

rcount = size(DT,1);
rnames = cell(rcount);
for i = 1:rcount-1,
    rnames{i} = ['Fold ',num2str(i)];
end
rnames{rcount} = 'Average';


ccount = 6;
cnames = cell(ccount);
for i = 1:ccount,
    cnames{i} = emolab2str(i);
end


f_DT = figure('Position',[200 200 650 250]);
f_NN = figure('Position',[200 200 650 250]);
f_CBR = figure('Position',[200 200 650 250]);


%DT plot
t_DT = uitable('Parent', f_DT,'Data',dat{1},'ColumnName',cnames,... 
            'RowName',rnames);
set(t_DT, 'Position', [0 0 650 250]);

%NN plot
t_NN = uitable('Parent', f_NN,'Data',dat{2},'ColumnName',cnames,... 
            'RowName',rnames);
set(t_NN, 'Position', [0 0 650 250]);

%CBR plot
t_CBR = uitable('Parent', f_CBR,'Data',dat{3},'ColumnName',cnames,... 
            'RowName',rnames);
set(t_CBR, 'Position', [0 0 650 250]);


plot(t_DT);
plot(t_NN);
plot(t_CBR);



 