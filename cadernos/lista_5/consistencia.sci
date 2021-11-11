function avaliaConsistenciaX(x, x_hat, P)
    xd = interp1(x.time, x.values, x_hat.time);
    dx = xd - x_hat.values;
    [eps, eps_i] = consistencia(dx, P.values);
    testeHipotese(eps, size(dx, 2));
    // testeHipoteseGaussiana(eps_i);
end


function [eps, eps_i] = consistencia(dx, P)
    samples = max(size(dx));
    n_states = size(P, 2);
    eps   = zeros(1, samples);
    eps_i = zeros(samples, n_states);

    for k = 1:samples
        eps(k) = dx(k, :) / P(:, :, k) * dx(k, :)';
        for j = 1:n_states
            eps_i(k, j) = dx(k, j) / sqrt(P(j, j, k)) ;
        end
    end

end

function [aceito, per_fora_menos, per_fora_mais, per_ok] = testeHipotese(eps, nx)

    n = max(size(eps));

    lin_inf_ind = cdfchi("X", nx, 0.05, 0.95);
    lin_sup_ind = cdfchi("X", nx, 0.95, 0.05);

    scf();
    semilogy(1:n, eps, 'o', ...
        [0 n], [lin_inf_ind lin_inf_ind], 'k:', ...
        [0 n], [lin_sup_ind lin_sup_ind], 'k:');
            
    title(['Teste de consistência ' '$\chi^2$' ' (NEES)']);
    
    per_fora_menos = max(size(eps(eps < lin_inf_ind))) / n * 100
    per_fora_mais  = max(size(eps(eps > lin_sup_ind))) / n * 100

    per_ok = 100 - per_fora_menos - per_fora_mais

    aceito = (per_ok >= 90);

end

function [ aceito, per_fora_menos, per_fora_mais, per_ok ] = testeHipoteseGaussiana( eps )

    n = max(size(eps));
    numMed = size(eps,2);

    for ii = 1:numMed

        lin_inf_ind = cdfnor("X", 0, 1, 0.05,0.95);
        lin_sup_ind = cdfnor("X", 0, 1, 0.95,0.05);
        
        scf();
        plot([1:n]' , eps(:,ii), 'o', ...
            [0 n], [lin_inf_ind lin_inf_ind], 'k:', ...
            [0 n], [lin_sup_ind lin_sup_ind], 'k:');
        
        title('Teste de consistência gaussiana (NMEE) - estado x' + string(ii));
        
        ii
        per_fora_menos = max(size(eps(:,ii)(eps(:,ii) <  lin_inf_ind)))/n*100
        per_fora_mais  = max(size(eps(:,ii)(eps(:,ii) >  lin_sup_ind)))/n*100
        
        per_ok(ii) = 100 - per_fora_menos - per_fora_mais
        aceito(ii) = (per_ok(ii) >= 90)
    end

end
