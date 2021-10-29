dx = xk.values - xk_hat.values;
[eps, eps_i] = consistencia(dx, Pk.values);
testeHipotese(eps,size(dx,2));
testeHipoteseGaussiana(eps_i);
