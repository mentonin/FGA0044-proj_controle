function D_NED_b = DCM(phi, theta, psi)

D_phi = [1 0 0;0 cos(phi) sin(phi); 0 -sin(phi) cos(phi)];
D_theta = [cos(theta) 0 -sin(theta); 0 1 0; sin(theta) 0 cos(theta)];
D_psi = [cos(psi) sin(psi) 0; -sin(psi) cos(psi) 0; 0 0 1];
D_NED_b = D_phi*D_theta*D_psi;

endfunction
