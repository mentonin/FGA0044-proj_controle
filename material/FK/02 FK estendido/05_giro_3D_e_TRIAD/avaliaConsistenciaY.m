[eps, eps_i] = consistencia(y_tilde.Data, S.Data);
[ aceito, per_fora_menos, per_fora_mais, per_ok ] = testeHipotese(eps,6)
[ aceito_g, per_fora_menos_g, per_fora_mais_g, per_ok_g ]= testeHipoteseGaussiana(eps_i)