FOLDER = "./graficos/"

function figs = plotsKF(u, x, y, u_m, y_m, x_hat, y_hat, P, prefixo)
    figs = [
        plotEstados(xk, x_hat, prefixo);
        plotP(Pk, prefixo);
        plotErro(yk, y_hat, prefixo);
        plotSaida(yk, y_m, y_hat, prefixo);
    ]
end

function [fig] = plotEstados(xk, x_hat, prefixo)
    fig = scf();
    plot(xk.time, xk.values, "-");
    plot(x_hat.time, x_hat.values, "--");
    gca().x_location = "origin";
    xtitle("Estados", "t (s)", "x", boxed=%T);
    legend([
        "$x_1$",
        "$x_2$",
        "$\hat{x}_1$",
        "$\hat{x}_2$",
    ]);
    xs2pdf(fig, FOLDER + prefixo + "estados");
end


function [fig] = plotP(Pk, prefixo)
    fig = scf();
    P_diag = zeros(size(Pk.values)(3), 2);
    for i=1:size(Pk.values)(1)
        P_diag(:, i) = Pk.values(i, i, :)(:);
    end
    plot(Pk.time, [P_diag]);
    xtitle("Variância Estimada", "t (s)", "P", boxed=%T);
    xs2pdf(fig, FOLDER + prefixo + "Pdiag");
end


function [fig] = plotErro(yk, y_hat, prefixo)
    fig = scf();
    plot(yk.time, y_hat.values - yk.values);
    gca().x_location = "origin";
    xtitle("Erro", "t (s)", "Potência (W)", boxed=%T);
    legend([
        "$\hat{y} - y$",
    ]);
    xs2pdf(fig, FOLDER + prefixo + "erro");
end


function [fig] = plotSaida(yk, y_m, y_hat, prefixo)
    fig = scf();
    plot(y_m.time, y_m.values, ":", "Color", "#CCCCCC");
    plot(yk.time, yk.values, "-");
    plot(y_hat.time, y_hat.values, "--");
    gca().x_location = "origin";
    xtitle("Sensor da antena", "t (s)", "Potência (W)", boxed=%T);
    legend([
        "$y_m$",
        "$y$",
        "$\hat{y}$",
    ]);
    xs2pdf(fig, FOLDER + prefixo + "saida");
end

    // exec("avaliaConsistenciaX.sce", 2);
    // xs2pdf(gcf(), "./graficos/chi2");
