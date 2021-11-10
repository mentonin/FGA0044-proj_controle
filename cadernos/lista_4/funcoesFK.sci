// Funcao utilizada na predicao. Propaga modelo linear.
// Ruido de modelo é considerado o ruido de entrada
function [x_k1_,P_k1_] = predicao(F, G, Q, u, x_k, P_k)
    x_k1_ = F * x_k + G * u;
    P_k1_ = F * P_k * F' + G * Q * G';
end

// Funcao calcAtualizacao é uma parte da funcao atualizacao, mais abaixo
function [x_k1, P_k1] = calcAtualizacao(H, R, y, x_k1_, P_k1_)
    // Trecho abaixo nao depende nem do estado estimado, nem da medida obtida,
    // entao pode ser calculado offline e armazenado em tabela
    S = H * P_k1_ * H' + R;
    Pxy = P_k1_ * H';
    K_k  =  Pxy / S;
    KH = K_k * H;
    I = eye(size(KH, 1), size(KH, 2));
    I_KH = I - KH;
    P_k1 = I_KH * P_k1_ * I_KH' + K_k * R * K_k';
    // --- fim do trecho que pode ser calculado offline

    y_hat = H * x_k1_;
    y_tilde = y - y_hat;
    x_k1 = x_k1_ + K_k * y_tilde;
end

// Funcao atualizacao seleciona quais sensores estão ativos, e envia para
// calcAtualizacao apenas sensor ativo, ou não chama função se nenhum
// sensor ativo.
function [x_k1, P_k1] = atualizacao(H, R, y, x_k1_, P_k1_, sensorLigado)
    if (sensorLigado(1) == 0) && (sensorLigado(2) == 0)
        x_k1 = x_k1_ ;
        P_k1 = P_k1_;
    else
        faixaVal = sensorLigado == 1;
        H_ = H(faixaVal, :);
        R_ = R(faixaVal, faixaVal);
        y_ = y(faixaVal);
        [x_k1, P_k1] = calcAtualizacao(H_, R_, y_, x_k1_, P_k1_);
    end
end
