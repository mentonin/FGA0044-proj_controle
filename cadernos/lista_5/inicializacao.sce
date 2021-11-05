// Período de amostragem
T = 0.01;

// Variâncias dos sensores
var_u = 1;
var_y = 1;

// Condições iniciais
x0 = [1; 0];
P0 = diag([4, 4]);
x0_hat = x0 + P0 * rand(2, 1, "n");

// Parâmetros da simulação
tf = 10;
buffer = ceil(tf / T) * 100;
