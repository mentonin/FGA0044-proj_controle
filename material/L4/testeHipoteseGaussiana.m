function [ aceito, per_fora_menos, per_fora_mais, per_ok ] = testeHipoteseGaussiana( eps )

n = length(eps);

for ii = 1:size(eps,2); % numMedidas

    acc(ii) = sum(eps(:,ii));
    
    lim_inf = 1/sqrt(n)*norminv(0.05);
    lim_sup = 1/sqrt(n)*norminv(0.95);
    
    aceito(ii) = (acc(ii) <= lim_sup) && (acc(ii) >= lim_inf);
    
    lin_inf_ind = norminv(0.05);
    lin_sup_ind = norminv(0.95);
    
    figure;
    plot(    1:n , eps(:,ii), 'o', ...
        [0 n], [lin_inf_ind lin_inf_ind], 'k:', ...
        [0 n], [lin_sup_ind lin_sup_ind], 'k:');
    
    xlim([0 n]);
    
    per_fora_menos = length(eps(eps <  lin_inf_ind))/n*100
    per_fora_mais  = length(eps(eps >  lin_sup_ind))/n*100
    
    per_ok = 100 - per_fora_menos - per_fora_mais
end

end

