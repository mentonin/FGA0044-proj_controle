// Planta
disp("Carregando funções do modelo...");
getd();

disp("Configurando parâmetros do modelo...");
exec("inicializacao.sce", 0);


// EKF
disp("Carregando EKF...");
sys = xcosDiagramToScilab("EKF.zcos");
sys.props.tf = tf;
sys.objs(7).model.rpar(2:3) = [1, 1] * 10;
sys.objs(7).graphics.exprs(8) = "10 10";

disp("Simulando EKF...");
xcos_simulate(sys, 4);

disp("Plotando EKF...");
plotsKF(cos(xk.time), xk, yk, u_m, y_m, x_hat, y_hat, Pk, "./graficos/EKF_");

// UKF
disp("Carregando UKF...");
sys = xcosDiagramToScilab("UKF.zcos");
sys.props.tf = tf;
sys.objs(7).model.rpar(2:3) = [1, 1] * 10;
sys.objs(7).graphics.exprs(8) = "10 10";

disp("Simulando UKF...");
xcos_simulate(sys, 4);

disp("Plotando UKF...");
plotsKF(cos(xk.time), xk, yk, u_m, y_m, x_hat, y_hat, Pk, "./graficos/UKF_");

disp("Finalizado");

