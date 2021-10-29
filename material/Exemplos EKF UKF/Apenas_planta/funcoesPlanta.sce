function [x_dot] = modeloPlanta(u, x)

phi = x(1);
the = x(2);
//psi = x(3);
A = [1 tan(the)*sin(phi)    tan(the)*sin(phi);
     0 cos(phi)             -sin(phi);
     0 sin(phi)/cos(the)    cos(phi)/cos(the)];
x_dot = A*u;

endfunction

function [y] = modeloSensor(x)

phi   = x(1);
theta = x(2);
psi   = x(3);

// Calculo da matriz de rotação, sequencia 3-2-1
// DCM definida no arquivo funcoesAtitude
D_NED_b = DCM(phi, theta, psi)

// Medidas dos sensores como vetores em S_NED rotacionados para S_b
m_b = D_NED_b * [1 0 0]';
a_b = D_NED_b * [0 0 -1]';

y = [m_b; a_b];

endfunction

