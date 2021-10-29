%% Ajuste dos parametros
% Condicoes iniciais da planta
x_ini = [5 2.5 5 2.5];
% x_ini = [0 0 0 0];

% Escolha controlador a ser testado
% 0 - Sem alocacao de polos (planta original)
% 1 - Alocacao de polos - usa apenas u1
% 2 - Alocacao de polos - usa u1 e u2
% 3 - LQR - usa u1 e u2
tipoControlador = 3;

% Polos do sistema em malha fechada
J = [(-2 +2j*sqrt(3)) (-2 -2j*sqrt(3)) -10 -12];

% Escolha observador a ser testado
% 1 - Apenas y1
% 2 - y1 e y2
tipoObservador = 2;

% Polos do observador
L = [-1 -2 -3 -4];
%L = [ (-4.5 + 7.7942i), (-4.5 - 7.7942i), -10, -12];
%L = [-1 -1 -2 -2];
% Incluir ruido?
% 0 - Nao
% 1 - Sim
ruido = 1;

% Matrizes de ponderacao LQR - teste varios valores de Q e R

%Q = 10*eye(4);
%

% Q = [10 0 0 0; 
%      0 10 0 0; 
%      0 0 1 0;
%      0 0 0 1];

Q = [1 0 0 0; 
     0 1 0 0; 
     0 0 10 0;
     0 0 0 10];
% 

%R = [1 0; 0 1];
R = [1 0; 0 1];
 

%% Planta
A = [0 0 1 0; 
     0 0 0 1; 
     -36 36 -0.6 0.6; 
     18 -18 0.3 -0.3];

 % Uma entrada
B1 = [0 0 1 0]';

% Duas entradas
B2 = [0 0;
      0 0;
      1 0;
      0 0.5];

% Uma saida
C1 = [1 0 0 0];

% Duas saidas
C2 = [1 0 0 0;
      0 1 0 0];
  
%% Projeto do controlador

% Alocacao de polos - 1 entrada
K1 = acker(A,B1,J);

% Alocacao de polos com mais de um grau de liberdade: place
K2 = place(A,B2,J);

% LQR
K_lqr = lqr(A,B2,Q,R);

% Escolha do ganho
switch tipoControlador
    case 0
        K_ctrl = zeros(size(K2));
    case 1
        K_ctrl = [K1;zeros(1,length(K1))];
    case 2
        K_ctrl = K2;
    case 3
        K_ctrl = K_lqr;
end
  
%% Observador de estados

% Observador de estados - uma saida
Ke_1 = acker(A',C1',L);

% Observador de estados - duas saidas
Ke_2 = place(A',C2',L);

% Escolha do ganho
switch tipoObservador
    case 1
        Ke = [Ke_1;zeros(1,length(K1))];
    case 2
        Ke = Ke_2;
end