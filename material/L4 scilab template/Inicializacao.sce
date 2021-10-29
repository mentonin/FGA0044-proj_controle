// x = [alpha, q, theta]
// u = delta_el
// Modelo linear obtido do artigo:
//    G. Campa et al. / Control Engineering Practice 15 (2007) 1077–1092
// Atividade parcialmente inspirada pelo tutorial:
//    http://ctms.engin.umich.edu/CTMS/index.php?example=AircraftPitch&section=ControlStateSpace
// Tutorial Scilab e Sistemas de Controle
// https://www.scilab.org/sites/default/files/Control-System-Toolbox-in-Scilab.pdf

// Digitar modelo contínuo existente na lista. Valores abaixo devem ser alterados
A = eye(3,3)
B = [1;2;3];
C = [1 0 0;1 0 0];

// Tempo de amostragem correto (10 ms), não ajustar
T = 0.01;

// Valores Ad e Bd abaixo são exemplo para que Xcos compile. Remover ao configurar valores mais abaixo
Ad = A;  // Remover
Bd = B;  // Remover 


// Estudar funcoes syslin e dscr do Scilab
// Sugestão: digitar 'help syslin' e 'help dscr' no workspace
// G_planta = (...);
// G_disc = (...);
// Ad = G_disc.A;
// Bd = G_disc.B;  

// Ao final, executar arquivos funcoesFK e funcoesConsistencia para cirar funções
// adequadas para o simulador Xcos 

