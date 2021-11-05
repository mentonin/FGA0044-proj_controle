function [mu_, cov_, X, Y, w] = unscentedTransform(mu, cov, fun)
    // Calcula a transformada Unscented de uma distribuição com uma 
    // função não linear
    // Entrada:
    //  mu: vetor de médias
    //  cov: matriz de covariância
    //  fun: função não linear
    // Saída:
    //  mu_: vetor de médias após transformação
    //  cov_: matriz de covariância após transformação
    //  X: pontos sigma da distribuição original
    //  Y: pontos sigma da distribuição transformada
    //  w: pesos dos pontos

    [X, w] = sigPoints(mu, cov);
    Y = fun(X);
    [mu_, cov_] = meanCov(Y, w);
end


function Pxy = crossCov(X, Y, x, y, w)
    // Calcula a covariância cruzada entre duas distribuições sigma
    // Entrada:
    //  X: pontos sigma da primeira distribuição
    //  Y: pontos sigma da segunda distribuição
    //  w: pesos dos pontos sigma
    //  x: vetor de médias da primeira distribuição
    //  y: vetor de médias da segunda distribuição
    
    Pxy = (X - x(:, ones(w))) * ((Y - y(:, ones(w))) .* w(ones(y), :))';
end

function [mu, cov] = meanCov(X, w)
    // Calcula a média e a covariância de uma distribuição sigma
    // Entrada:
    //  X: pontos sigma da distribuição
    //  w: pesos dos pontos sigma
    // Saída:
    //  mu: vetor de médias
    //  cov: matriz de covariância

    mu = X * w';
    cov = X - mu(:, ones(w));
    cov = cov * (cov .* w(ones(mu), :))';
end


function [X, w] = sigPoints(mu, cov)
    // Calcula os pontos sigma a partir da média e covariância
    // Entrada:
    //  mu: vetor de médias
    //  cov: matriz de covariância
    // Saída:
    //  X: pontos sigma
    //  w: pesos dos pontos sigma

    n = length(mu);
    lambda = 3 - n;
    kappa = 3;
    KP = sqrt(3) * chol(cov);
    X = [zeros(mu), KP, -KP];
    w = (1 / (2 * kappa))(:, ones(1, 2 * n + 1));
    w(1) = lambda / kappa;
    X = X + mu(:, ones(w));
end


function [x_inter, P_inter] = predicaoUKF(u, x_old, P_old, Q, T)
    // Efetua a etapa de predição do UKF. Calcula as matrizes jacobianas
    // do modelo e os valores estimados dos estados e da variância.
    // Entrada:
    // u: vetor de entrada
    // x_old: estado anterior
    // P_old: matriz de covariância do estado anterior
    // Q: matriz de covariância do ruído da entrada
    // T: período de amostragem
    // Saída:
    // x_inter: estado estimado
    // P_inter: matriz de covariância estimada

    n = length(x_old);
    f = deff("x_ = @(x) x + T * modeloPlanta(x, u(:, ones(1, 2 * n + 1)))");
    G = JacobianoG(x_old, u, T);

    [x_inter, P_inter] = unscentedTransform(x_old, P_old, f);
    P_inter = P_inter + G * Q * G';
end


function [y_hat, x_new, P_new] = atualizacaoUKF(y_m, x_inter, P_inter, R)
    // Efetua a etapa de atualização do UKF. Calcula a matriz jacobiana
    // do sensor e os valores estimados de y e da variância.
    // Entrada:
    // y_m: valor do sensor
    // x_inter: estado estimado
    // P_inter: matriz de covariância do estado estimado
    // R: matriz de covariância do sensor
    // Saída:
    // y_hat: valor estimado do sensor
    // x_new: estado estimado atualizado
    // P_new: matriz de covariância do estado estimado atualizado

    h = deff("y = @(x) modeloSaidas(x)");

    [y_hat, S, X, Y, w] = unscentedTransform(x_inter, P_inter, h);
    S = S + R;
    Pxy = crossCov(X, Y, x_inter, y_hat, w);
    K = Pxy / S;
    x_new = x_inter + K * (y_m - y_hat);
    P_new = P_inter - K * Pxy';
end
