function [ aceito, per_fora_menos, per_fora_mais, per_ok ] = testeHipotese( eps, nx )

n = length(eps);
acc = sum(eps);

lim_inf = chi2inv(0.05,n*nx);
lim_sup = chi2inv(0.95,n*nx);

aceito = (acc <= lim_sup) && (acc >= lim_inf);

lin_inf_ind = chi2inv(0.05,nx);
lin_sup_ind = chi2inv(0.95,nx);

semilogy(    1:n , eps, 'o', ...
            [0 n], [lin_inf_ind lin_inf_ind], 'k:', ...
            [0 n], [lin_sup_ind lin_sup_ind], 'k:');

% plot(       1:n , eps, 'o', ...
%             [0 n], [lin_inf_ind lin_inf_ind], 'k:', ...
%             [0 n], [lin_sup_ind lin_sup_ind], 'k:');

xlim([0 n]);
  
per_fora_menos = length(eps(eps <  lin_inf_ind))/n*100
per_fora_mais  = length(eps(eps >  lin_sup_ind))/n*100

per_ok = 100 - per_fora_menos - per_fora_mais


end

