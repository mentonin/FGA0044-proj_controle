% Sistema original
% lambda = -1, -2, -3
A = [0 1 0; 0 0 1; -6 -11 -6];
B = [0; 0; 1];
C = [1 0 0];
MA = ss(A,B,C,0);

% Projeto - Vetor de estados aumentado (adição de integrador -> mudança para tipo 1)
A_aug = [A zeros(3,1);-C 0];
B_aug = [B; 0];
C_aug = [C 0];

% Polos desejados
J = [-2+2j*sqrt(3) -2-2j*sqrt(3)  -10 -10];
K = acker(A_aug,B_aug,J);

A_novo = A_aug - B_aug*K;
%A_novo_1 = [A - B*K(1:3) -B*K(4);-C 0];
B_novo = [0;0;0;1];

MF = ss(A_novo,B_novo,C_aug,0);
step(MF)
