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
D_phi = [1 0 0;0 cos(phi) sin(phi); 0 -sin(phi) cos(phi)];
D_theta = [cos(theta) 0 -sin(theta); 0 1 0; sin(theta) 0 cos(theta)];
D_psi = [cos(psi) sin(psi) 0; -sin(psi) cos(psi) 0; 0 0 1];
D_NED_b = D_phi*D_theta*D_psi;

// Medidas dos sensores como vetores em S_NED rotacionados para S_b
m_b = D_NED_b * [1 0 0]';
a_b = D_NED_b * [0 0 -1]';

y = [m_b; a_b];

endfunction

