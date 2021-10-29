dx = x_k_true.Data - x_k.Data;
[eps, eps_i] = consistencia(dx, P_k.Data);
[ aceito, per_fora_menos, per_fora_mais, per_ok ] = testeHipotese(eps,3)
[ aceito_g, per_fora_menos_g, per_fora_mais_g, per_ok_g ] = testeHipoteseGaussiana(eps_i)