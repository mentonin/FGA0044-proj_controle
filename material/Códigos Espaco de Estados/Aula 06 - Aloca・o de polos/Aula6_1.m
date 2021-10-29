% Sistema original
% lambda = -1, -2, -3
% Sistema tipo 0
A = [0 1 0; 0 0 1; -6 -11 -6];
B = [0; 0; 1];
C = [1 0 0];
MA = ss(A,B,C,0);

% Projeto
% Polos desejados
J = [-2+2j*sqrt(3) -2-2j*sqrt(3)  -10];
K = acker(A,B,J);

A_novo = A - B*K;
B_novo = B * K(1); % Esse ajuste de ganho causa erro em regime permanente, pois sistema tipo 0 e ajuste usual 

MF = ss(A_novo,B_novo,C,0);
step(MF)

B_novo_1 = -A_novo(3,1) * B;
MF_1 = ss(A_novo,B_novo_1,C,0);
step(MF_1)
