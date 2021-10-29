dx = x_k_true.Data - x_k.Data;
[eps, eps_i] = consistencia(dx, P_k.Data);
testeHipotese(eps,2)
testeHipoteseGaussiana(eps_i)