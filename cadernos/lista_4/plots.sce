scf();
plot(yk.time, yk.values, "-");
plot(yk_hat.time, yk_hat.values, "--");
plot(yk_m.time, yk_m.values, ":");
gca().x_location = "origin";
xtitle("Saídas", "t (s)", "ângulo (rad)", boxed=%T);
legend([
    "$\alpha$",
    "$\theta$",
    "$\hat\alpha$",
    "$\hat\theta$",
    "$\alpha_m$",
    "$\theta_m$",
]);
xs2pdf(gcf(), "./graficos/estados");

exec("PlotPk_L4.sce", 2);
xs2pdf(gcf(), "./graficos/Pdiag");

scf();
plot(yk.time, yk_hat.values - yk.values);
gca().x_location = "origin";
xtitle("Erro", "t (s)", "ângulo (rad)", boxed=%T);
legend([
    "$\hat\alpha - \alpha$",
    "$\hat\theta - \theta$",
]);
xs2pdf(gcf(), "./graficos/erro");

exec("avaliaConsistenciaX.sce", 2);
xs2pdf(gcf(), "./graficos/chi2");
