function [x_] = modeloPlanta(x, u)
    // Modelo contínuo da planta. Calcula a derivada do vetor de estados
    // a partir do vetor de estados e da entrada de controle.
    // Entrada:
    // x: vetor de estados
    // u: vetor de controle
    // Saída:
    // x_: derivada do vetor de estados

    x_(1, :) = x(2, :);
    x_(2, :) = - x(2, :) .* abs(x(2, :)) + u;
end


function [y] = modeloSaidas(x)
    // Modelo contínuo do sensor. Calcula as saídas do modelo a partir
    // do vetor de estados.
    // Entrada:
    // x: vetor de estados

    y = 10 * exp(-x(1, :));
end


function [F] = JacobianoF(x, u, T)
    // Calcula o jacobiano da função de planta relativo ao vetor de estados.
    // Entrada:
    // x: vetor de estados
    // u: vetor de controle
    // T: período de amostragem

    F = [0, 1;
        0, -2 * abs(x(2))];
    F = eye(F) + (F * T);
end


function [G] = JacobianoG(x, u, T)
    // Calcula o jacobiano da função de planta relativo ao vetor de entrada.
    // Entrada:
    // x: vetor de estados
    // u: vetor de controle
    // T: período de amostragem

    G = [0;
         1];
    G = G * T;
end


function [H] = JacobianoH(x, u, T)
    // Calcula o jacobiano da função de saída relativo ao vetor de estados.
    // Entrada:
    // x: vetor de estados
    // u: vetor de controle
    // T: período de amostragem

    H = [-10 * exp(-x(1)), 0];
end
