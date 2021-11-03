// x = [alpha, q, theta]
// u = delta_el
// Modelo linear obtido do artigo:
//    G. Campa et al. / Control Engineering Practice 15 (2007) 1077–1092
// Atividade parcialmente inspirada pelo tutorial:
//    http://ctms.engin.umich.edu/CTMS/index.php?example=AircraftPitch&section=ControlStateSpace
// Tutorial Scilab e Sistemas de Controle
// https://www.scilab.org/sites/default/files/Control-System-Toolbox-in-Scilab.pdf


// Matrizes do modelo contínuo extraídas da lista.
A = [ -4.1172,  0.7781, 0.0;
     -33.8836, -3.5729, 0.0;
       0.0   ,  1.0   , 0.0];

B = [0.5435, -39.0847, 0.0]';

C = [1, 0, 0;
     0, 0, 1];

// Tempo de amostragem correto (10 ms), não ajustar
T = 0.01;

// Matrizes do modelo discreto calculadas pelo scilab
sys_d = dscr(syslin('c', A, B, C), T);
Ad = sys_d.A;
Bd = sys_d.B;

// Condições iniciais
x0 = [0.5, 0, -0.1]';

// Variância dos sensores
var_alpha = 16e-2;
var_theta = 4e-2;
var_delta = 1e-2;
sigma_alpha = sqrt(var_alpha);
sigma_theta = sqrt(var_theta);
sigma_delta = sqrt(var_delta);

// Matrizes de erro do sistema
Q = [var_delta]
R = [var_alpha 0; 0 var_theta]

// Importa funções definidas em arquivos na mesma pasta (.sci)
getd();
