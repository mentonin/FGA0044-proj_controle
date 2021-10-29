function [x, P, sig_noMean] = unsTrans(sig, peso) 
n = size(sig,2);

x = (sig(:,1)*peso(1) + sum(sig(:,2:n),2)*peso(2))/(peso(1) + (n-1) * peso(2));
sig_noMean = sig - x(:, ones(1,n));
P = unsCov(sig_noMean, sig_noMean, peso);

end