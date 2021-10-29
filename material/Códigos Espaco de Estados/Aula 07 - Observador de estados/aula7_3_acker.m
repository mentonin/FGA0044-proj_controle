% Sistema original
A = [0 1; 20.6 0];
B = [0; 1];
C = [1 0];

% Projeto
A_aug = [A zeros(2,1);-C 0];
B_aug = [B; 0];
C_aug = [C 0];
% Polos desejados
J = [-1.8+2.4j -1.8-2.4j -5];
K = acker(A_aug,B_aug,J);
