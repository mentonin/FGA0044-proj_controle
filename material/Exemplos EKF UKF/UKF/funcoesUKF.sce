// ---- PARTE 1 - FUNCOES DE PREDICAO -----

// Funcao possivelmente nao linear da matriz G
function G = calculaG(x_k)

T = 0.01;

phi = x_k(1);
the = x_k(2);
psi = x_k(3);

A = [1 tan(the)*sin(phi)    tan(the)*sin(phi);
     0 cos(phi)             -sin(phi);
     0 sin(phi)/cos(the)    cos(phi)/cos(the)];
G = A * T; 

endfunction

// Funcao possivelmente nao linear da predicao - especifica para cada caso
function x_k1_ = predicaoIndividualSP(x_k,u)

G = calculaG(x_k);

// Discretizacao a partir de função nao linear continua
// Veja que, neste caso em particular, G*u = f(x,u)*T. Isso provavelmente nao 
// ocorre em outras plantas
x_k1_ = x_k + G*u;

endfunction

// Prediz os 2n+1 pontos sigma
function X_k1_ = predSig(X_k, u)

nSig = size(X_k,2);
X_k1_ = zeros(size(X_k,1),nSig);
for ii = 1:nSig
    X_k1_(:,ii) = predicaoIndividualSP(X_k(:,ii),u);
end    

endfunction


function [x_k1_,P_k1_] = predicaoUKF(Q, u, x_k, P_k)


// Parametros que devem ser configurados
lambda = 1;         // Intensidade da dispersão dos pontos (valor arbitrario, sugiro deixar 1)
G = calculaG(x_k);  // Definir G corretamente (constante ou variavel no tempo)

// A partir daqui, codigo UKF usual, nao necessita edicoes
Qd = G*Q*G';

n = size(x_k,1);
kappa = n + lambda;
peso_1 = lambda/kappa;
peso_2 = 1/(2*kappa);

// gera 2n + 1 sigma points
X_k  = sigmas(x_k,P_k,kappa);

X_k1_ = predSig(X_k, u);

[x_k1_, P_k1_semQ] = unsTrans(X_k1_, [peso_1 peso_2]);

P_k1_ = P_k1_semQ + Qd;

endfunction

// ---- PARTE 2 - FUNCOES DE ATUALIZACAO -----

// Funcao possivelmente nao linear da predicao de medida de sensor- especifica para cada caso
function y_hat = sensorEstUKF(x_k)

phi = x_k(1);
the = x_k(2);
psi = x_k(3);

D_NED_b = DCM(phi, the, psi);

m_b = D_NED_b * [1 0 0]';
a_b = D_NED_b * [0 0 -1]';

y_hat = [m_b; a_b];

endfunction

// Prediz medidas de sensor a partir de 2n+1 pontos sigma
function Y_k = sensorSig(X_k)

nSig = size(X_k,2);
Y_k_temp = sensorEstUKF(X_k(:,1));
Y_k = zeros(size(Y_k_temp,1),nSig);
Y_k(:,1) = Y_k_temp;
for ii = 2:nSig
    Y_k(:,ii) = sensorEstUKF(X_k(:,ii));
end    

endfunction


function [x_k1, P_k1, y_hat] = atualizacaoUKF(R, y, x_k1_, P_k1_)

// Intensidade da dispersão dos pontos
lambda = 1;

// A partir daqui, codigo UKF usual, nao necessita edicoes
n = size(x_k1_,1);
kappa = n + lambda;
peso_1 = lambda/kappa;
peso_2 = 1/(2*kappa);

// gera 2n + 1 sigma points
[X_k, X_k_noMean]  = sigmas(x_k1_,P_k1_,kappa);

Y_k = sensorSig(X_k);
[y_hat, S_semR, Y_k_noMean] = unsTrans(Y_k, [peso_1 peso_2]);
S = S_semR + R;
Pxy = unsCov(X_k_noMean, Y_k_noMean, [peso_1 peso_2]);

K_k  =  Pxy / S;
P_k1 = P_k1_ - K_k * S * K_k';


y_tilde = y - y_hat;
x_k1 = x_k1_ + K_k * y_tilde; 

endfunction




