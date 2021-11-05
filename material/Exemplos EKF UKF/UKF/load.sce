exec("funcoesAtitude.sce", 0);
exec("funcoesPlanta.sce", 0);
exec("funcoesUKFaux.sce", 0);
exec("funcoesUKF.sce", 0);
calculaG = deff("y = @(x) [0; T]");

function x_k1_ = predicaoIndividualSP(x_k,u)
    x_k1_(1) = x_k(1) + T * x_k(2);
    x_k1_(2) = x_k(2) + T * (u - abs(x_k(2)) * x_k(2))
end

deff("y = sensorEstUKF(x) 10 * exp(-x(1))")
