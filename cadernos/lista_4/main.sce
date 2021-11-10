getd();
exec("Inicializacao.sce", 0);

sys = xcosDiagramToScilab("./Modelo.zcos");
sys.props.tf = 10;
// sys.objs(7).model.rpar(2:3) = [1, 1] * 10;
// sys.objs(7).graphics.exprs(8) = "10 10";

sensores = [1, 1];
xcos_simulate(sys, 4);
plotsKF(0.1, xk, yk, 0.1, yk_m, xk_hat, yk_hat, Pk, "./graficos/3a_");
fig = scf();
plot(xk.time, xk.values)
legend([
    "$\alpha$",
    "$q$",
    "$\theta$",
]);
xtitle("Estados da planta", "t (s)", "x", boxed=%T);
xs2pdf(fig, "./graficos/2_estados.pdf");

sensores = [0, 0];
xcos_simulate(sys, 4);
plotsKF(0.1, xk, yk, 0.1, yk_m, xk_hat, yk_hat, Pk, "./graficos/3b_");

sensores = [1, 0];
xcos_simulate(sys, 4);
plotsKF(0.1, xk, yk, 0.1, yk_m, xk_hat, yk_hat, Pk, "./graficos/3c_");

sensores = [0, 1];
xcos_simulate(sys, 4);
plotsKF(0.1, xk, yk, 0.1, yk_m, xk_hat, yk_hat, Pk, "./graficos/3d_");
