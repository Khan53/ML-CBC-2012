function f_measure = calculate_f_measure(rp_rates,alpha)
%CALCULATE_F_MEASURE - Calculates the F measure for the rp_rates
%                       using the given alpha as weight of precision
%                       and recall
%
%IN:  rp_rates - a set of recall/precision rates [Nx2]
%OUT: f_measure - the f-measure of each class [Nx1]
dim = size(rp_rates,1);
f_measure = zeros(dim,1);
for i = 1:dim,
<<<<<<< HEAD
      f_measure(i,1) = (1 + alpha) * (( rp_rates(i,2) * rp_rates(i,3)) / (alpha * rp_rates(i,3) + rp_rates(i,2)));
end
=======
  if rp_rates(i,2) ~= 0 || rp_rates(i,3) ~= 0
    f_measure(i,1) = (1 + alpha) * (( rp_rates(i,2) * rp_rates(i,3)) / (alpha * rp_rates(i,3) + rp_rates(i,2)));
  end
end
>>>>>>> 76e83b2b321217f4e3e9dd64aa212c83da9d54af
