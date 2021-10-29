% Sistema original - Tipo 1 - Erro nulo em entrada degrau
A = [0 1 0; 0 0 1; 0 -2 -3]; % O primeiro zero indica sistema tipo 1 (converter para FT para verificar)
B = [0; 0; 1];
C = [1 0 0];
MA = ss(A,B,C,0);

% Projeto
% Polos desejados
J = [-2+2j*sqrt(3) -2-2j*sqrt(3)  -10];
K = acker(A,B,J);

A_novo = A - B*K;
B_novo = B * K(1); % O ganho deve ser aplicado na entrada também, não apenas na realimentacao

MF = ss(A_novo,B_novo,C,0);
step(MF)