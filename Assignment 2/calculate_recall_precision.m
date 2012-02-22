function rp_rates = calculate_recall_precision(conf_matrix)
%CALCULATE_RECALL_PRECISION - Calaulates recall and precision
%               rates for the given confusion matrix and combines
%               them into the f measure
%
%IN:  conf_matrix - a confusion matrix [NxN]
%OUT: rp_rates - [N X 2] matrix with recall and precision values
dim = size(conf_matrix,1);
rp_rates = zeros(dim,3);
matrix_sum = sum(sum(conf_matrix));
conf_matrix
for i = 1:dim,
    if sum(conf_matrix(i,:)) > 0
        rp_rates(i,2) = (conf_matrix(i,i) / sum(conf_matrix(i,:))) * 100; % Recall rate
    end
    if sum(conf_matrix(:,i)) > 0
        rp_rates(i,3) = (conf_matrix(i,i) / sum(conf_matrix(:,i))) * 100; % Precision rate
    end
    rp_rates(i,1) = 100 - (((2*conf_matrix(i,i)+ matrix_sum - sum(conf_matrix(i,:)) - sum(conf_matrix(:,i))) / matrix_sum ) * 100); % Error estimate
end