function avaliaConsistenciaX(x, x_hat, P)
    dx = x.values - x_hat.values;
    [eps, eps_i] = consistencia(dx, P.values);
    testeHipotese(eps, size(dx, 2));
    // testeHipoteseGaussiana(eps_i);
end
