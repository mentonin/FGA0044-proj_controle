function [figs] = plotsKF(u, x, y, u_m, y_m, x_hat, y_hat, P, base_path)
    figs = [
        plotEstados(x, x_hat, base_path);
        plotP(P, base_path);
        plotErro(y, y_hat, base_path);
        plotSaida(y, y_m, y_hat, base_path);
    ];
end

function [fig] = plotEstados(x, x_hat, base_path)
    fig = scf();
    plot(x.time, x.values, "-");
    plot(x_hat.time, x_hat.values, "--");
    gca().x_location = "origin";
    xtitle("Estados reais e estimados", "t (s)", "x", boxed=%T);
    legend([
        "$x_1$",
        "$x_2$",
        "$\hat{x}_1$",
        "$\hat{x}_2$",
    ]);
    replot([%nan, %nan; -1, 3]);
    xs2pdf(fig, base_path + "estados");
end


function [fig] = plotP(P, base_path)
    fig = scf();
    P_diag = zeros(size(P.values)(3), 2);
    for i=1:size(P.values, 1)
        P_diag(:, i) = P.values(i, i, :)(:);
    end
    plot("nl", P.time, [P_diag]);
    xtitle("Variância Estimada", "t (s)", "P", boxed=%T);
    legend([
        "$x_1$",
        "$x_2$"
    ]);
    xs2pdf(fig, base_path + "Pdiag");
end


function [fig] = plotErro(y, y_hat, base_path)
    fig = scf();
    y_ = interp1(y.time, y.values, y_hat.time);
    plot(y_hat.time, y_ - y_hat.values);
    gca().x_location = "origin";
    xtitle("Erro", "t (s)", "Potência (W)", boxed=%T);
    legend([
        "$y - \hat{y}$",
    ]);
    replot([%nan, %nan; -1, 1]);
    xs2pdf(fig, base_path + "erro");
end


function [fig] = plotSaida(y, y_m, y_hat, base_path)
    fig = scf();
    log_flag = "nn"
    plot(log_flag, y_m.time, y_m.values, ":", "Color", "#CCCCCC");
    plot(log_flag, y.time, y.values, "-");
    plot(log_flag, y_hat.time, y_hat.values, "--", "Color", "#FF7F0E");
    gca().x_location = "origin";
    xtitle("Sensor da antena", "t (s)", "Potência (W)", boxed=%T);
    legend("$y_m$", "$y$", "$\hat{y}$");
    replot([%nan, %nan; 1, 20]);
    xs2pdf(fig, base_path + "saida");
end

    // exec("avaliaConsistenciaX.sce", 2);
    // xs2pdf(gcf(), "./graficos/chi2");
