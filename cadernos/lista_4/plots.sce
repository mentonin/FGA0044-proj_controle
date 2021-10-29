scf();
plot(yk.time, yk.values, '-');
plot(yk_hat.time, yk_hat.values, '--');
plot(yk_m.time, yk_m.values, ':');
gca().x_location = "origin";
xtitle('Saídas', 't (s)', 'ângulo (rad)');
legend([
    '$\alpha$',
    '$\theta$',
    '$\hat\alpha$',
    '$\hat\theta$',
    '$\alpha_m$',
    '$\theta_m$',
]);

exec("PlotPk_L4.sce", -1);

scf();
plot(yk.time, yk_hat.values - yk.values);
gca().x_location = "origin";
xtitle('Erro', 't (s)', 'ângulo (rad)');

exec("avaliaConsistenciaX.sce", -1);
