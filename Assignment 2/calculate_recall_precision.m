function rp_rates = calculate_recall_precision(conf_matrix)
%CALCULATE_RECALL_PRECISION - Calaulates recall and precision
%               rates for the given confusion matrix and combines
%               them into the f measure
%
%IN:  conf_matrix - a confusion matrix [NxN]
%OUT: rp_rates - [N X 2] matrix with recall and precision values
dim = size(conf_matrix,1);
rp_rates = zeros(dim,2);
for i = 1:dim,
    rp_rates(i,1) = (conf_matrix(i,i) / sum(conf_matrix(i,:))) * 100; % Recall rate
    rp_rates(i,2) = (conf_matrix(i,i) / sum(conf_matrix(:,i))) * 100; % Precision rate
end