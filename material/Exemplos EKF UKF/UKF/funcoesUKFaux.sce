function [X, X_noMean] = sigmas(x,P,kappa)

A = sqrt(kappa)*chol(P)';
B = x(:,ones(1,size(x,1)));
X = [x B+A B-A];
X_noMean = [zeros(size(x,1),size(x,2)), A, -A];

endfunction

function P = unsCov(noMean1, noMean2, peso)
n = size(noMean1,2);
P = peso(1)*(noMean1(:,1)*noMean2(:,1)') + peso(2)*(noMean1(:,2:n)*noMean2(:,2:n)');

endfunction

function [x, P, sig_noMean] = unsTrans(sig, peso) 
n = size(sig,2);

x = (sig(:,1)*peso(1) + sum(sig(:,2:n),2)*peso(2))/(peso(1) + (n-1) * peso(2));
sig_noMean = sig - x(:, ones(1,n));
P = unsCov(sig_noMean, sig_noMean, peso);

endfunction
