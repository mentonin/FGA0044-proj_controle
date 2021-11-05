// Importa funções da planta
// exec("./funcoes_planta.sci", -1);

function [x_inter, P_inter] = predicaoEKF(u, x_old, P_old, Q, T)
    // Efetua a etapa de predição do EKF. Calcula as matrizes jacobianas
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
    
    F = JacobianoF(x_old, u, T);
    G = JacobianoG(x_old, u, T);

    x_inter = x_old + T * modeloPlanta(x_old, u);
    P_inter = F * P_old * F' + G * Q * G';
end


function [y_hat, x_hat, P_hat] = atualizacaoEKF(y_m, x_inter, P_inter, R)
    // Efetua a etapa de atualização do EKF. Calcula a matriz jacobiana
    // do sensor e os valores estimados de y e da variância.
    // Entrada:
    // y_m: valor do sensor
    // x_inter: estado estimado
    // P_inter: matriz de covariância do estado estimado
    // R: matriz de covariância do sensor
    // Saída:
    // y_hat: valor estimado da saída
    // x_hat: estado estimado atualizado
    // P_hat: matriz de covariância do estado estimado atualizado

    H = JacobianoH(x_inter);

    y_hat = modeloSaidas(x_inter);
    ey = y_m - y_hat;
    S = (H * P_inter * H') + R;
    K = P_inter * H' * inv(S);
    x_hat = x_inter + (K * ey);
    P_hat = (eye(P_inter) - K * H) * P_inter;
end
