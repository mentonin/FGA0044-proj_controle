function [X, X_noMean] = sigmas(x,P,kappa)
%#codegen

A = sqrt(kappa)*chol(P)';
B = x(:,ones(1,numel(x)));
X = [x B+A B-A];
X_noMean = [zeros(size(x)), A, -A];

end

