// Predicao
function [x_k1_,P_k1_] = predicaoEKF(Q, u, x_k, P_k)

T = 0.01;
phi = x_k(1);
the = x_k(2);
psi = x_k(3);
dp = u(1)*T;
dq = u(2)*T;
dr = u(3)*T;
A = [1 tan(the)*sin(phi)    tan(the)*sin(phi);
0 cos(phi)             -sin(phi);
0 sin(phi)/cos(the)    cos(phi)/cos(the)];
G = A * T; 

// Discretizacao a partir de função nao linear continua
// Veja que G*u = f(x,u)*T
x_k1_ = x_k + G*u;

// Calculo da jacobiana
F_11 = 1 + tan(the) * (cos(phi)*dq - sin(phi)*dr);
F_12 = (sec(the))^2 * (sin(phi)*dq + cos(phi)*dr);
F_13 = 0;

F_21 = -sin(phi)*dq - cos(phi)*dr;
F_22 = 1;
F_23 = 0;

F_31 = sec(the)*(cos(phi)*dq - sin(phi)*dr);
F_32 = sec(the)*tan(the)*(sin(phi) * dq + cos(phi)*dr);
F_33 = 1;

F = [F_11 F_12 F_13; F_21 F_22 F_23; F_31 F_32 F_33];

// Calculo usual (igual ao filtro de Kalman linear) da matriz P
P_k1_ = F*P_k*F' + G*Q*G';

endfunction

// Funcoes da atualizacao
// Parte 1 - funcoes relacionadas aos calculos das jacobianas - ver slides
//           deve ser alterada conforme planta

// Jacobiana do sensor magnetometro
function H = h_mag(phi, the, psi)

sPs = sin(psi);
cPs = cos(psi);
sTh = sin(the);
cTh = cos(the);
sPh = sin(phi);
cPh = cos(phi);

H = [0                          -cPs*sTh        -sPs*cTh;
      cPs*sTh*cPh + sPs*sPh     cPs*cTh*sPh     -sPs*sTh*sPh - cPs*cPh;
     -cPs*sTh*sPh + sPs*cPh     cPs*cTh*cPh     -sPs*sTh*cPh + cPs*sPh];
end

// Jacobiana do sensor acelerometro
function H = h_acc(phi, the)

sTh = sin(the);
cTh = cos(the);
sPh = sin(phi);
cPh = cos(phi);

H = [ 0         cTh         0;
     -cTh*cPh   sTh*sPh     0;
      cTh*sPh   sTh*cPh     0];
end


// Funcoes da atualizacao
// Parte 2 - equacoes do EKF. Usualmente nao deve ser editado

// Exemplo de outras possiveis saidas, mas que foram removidas pois nao sao usadas aqui
//function [K_k, S, y_tilde, x_k1, P_k1] = atualizacaoEKF(R, y, x_k1_, P_k1_)

function [x_k1, P_k1, y_hat] = atualizacaoEKF(R, y, x_k1_, P_k1_)
phi = x_k1_(1);
the = x_k1_(2);
psi = x_k1_(3);

D_NED_b = DCM(phi, the, psi);

m_b = D_NED_b * [1 0 0]';
a_b = D_NED_b * [0 0 -1]';

y_hat = [m_b; a_b];

H = [ h_mag(phi, the, psi);
      h_acc(phi, the) ];

// A partir daqui, mesmas equacoes que FK linear

S = H * P_k1_ * H' + R;
Pxy = P_k1_ * H';
K_k  =  Pxy / S;
KH = K_k*H;
I = eye(size(KH, 1), size(KH, 2))
I_KH = I - KH;
P_k1 = I_KH * P_k1_ * I_KH' + K_k * R * K_k';

y_tilde = y - y_hat;
x_k1 = x_k1_ + K_k * y_tilde; 

end


