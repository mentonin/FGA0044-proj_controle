function efetuaMonteCarlo(N)

%dx_vect, eps_vect, eps_i_vect, y_tilde_vect, eps_r_vect, eps_ri_vect

mdl = 'SimulinkMonteCarlo';               % arquivo do simulink que sera executado 


% Abre modelo
load_system(mdl);
set_param(mdl, 'SimulationMode', 'normal'); % 'normal','rapid','accelerator'

% Simulacao
disp(['Simulacao 1 de ' int2str(N)]);

[dx, eps, eps_i, y_tilde, eps_r, eps_ri] =  simulaEPegaDados(mdl);
    
dx_vect = zeros( [size(dx) N]);
eps_vect = zeros ( [size(eps) N]);
eps_i_vect = zeros ( [size(eps_i) N]);

y_tilde_vect = zeros ( [size(y_tilde) N]);
eps_r_vect = zeros ( [size(eps_r) N]);
eps_ri_vect = zeros ( [size(eps_ri) N]);

dx_vect(:,:,1) = dx;
eps_vect(:,:,1) = eps;
eps_i_vect(:,:,1) = eps_i;
y_tilde_vect(:,:,1) = y_tilde;
eps_r_vect(:,:,1) = eps_r;
eps_ri_vect(:,:,1) = eps_ri;

%close_system(mdl)

for i = 2:N
    disp(['Simulacao ' int2str(i) ' de ' int2str(N)]);
    
    [dx_vect(:,:,i), eps_vect(:,:,i), eps_i_vect(:,:,i), ...
      y_tilde_vect(:,:,i), eps_r_vect(:,:,i), eps_ri_vect(:,:,i)] = ...
      simulaEPegaDados(mdl);
end

save vetorResultados *vect;

mean_eps = mean(eps_vect,3);
mean_eps_i = mean(eps_i_vect,3);
mean_eps_r = mean(eps_r_vect,3);
mean_eps_ri = mean(eps_ri_vect,3);

save medias mean*;

end

function [dx, eps, eps_i, y_til, eps_r, eps_ri] =  simulaEPegaDados(mdl)
sim(mdl, 'SimulationMode', 'normal');

load('P_k.mat');
load('S.mat');
load('x_k.mat');
load('x_k_true.mat');
load('y_tilde.mat');

dx = x_k_true.Data - x_k.Data;
[eps, eps_i] = consistencia(dx, P_k.Data);
y_til = y_tilde.Data;
[eps_r, eps_ri] = consistencia(y_til, S.Data);

end


