function f_measure = calculate_f_measure(rp_rates,alpha)
%CALCULATE_F_MEASURE - Calculates the F measure for the rp_rates
%                       using the given alpha as weight of precision
%                       and recall
%
%IN:  rp_rates - a set of recall/precision rates [Nx2]
%OUT: f_measure - the f-measure of each class [Nx1]

for i = 1:size(rp_rates,1)
      f_measure(i,1) = (1 + alpha) * (( rp_rates(i,1) * rp_rates(i,2)) / (alpha * rp_rates(i,2) + rp_rates(i,1)));
end