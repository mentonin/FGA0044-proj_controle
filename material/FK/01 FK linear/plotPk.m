function [ output_args ] = plotPk( Pk )
%PLOTPK Summary of this function goes here
%   Detailed explanation goes here
P = Pk.Data;
t = Pk.Time;

if ndims(P) == 2
    plot(t, P);
    
else
    for ii = 1:length(P)
        traceP(ii) = trace(P(:,:,ii));
        eigP(:,ii) = eig(P(:,:,ii));
        diaP(:,ii) = diag(P(:,:,ii));
    end
    figure;
    semilogy(t, traceP);
    title('Trace');
    figure;
    semilogy(t, eigP);
    title('Autovalores');
    figure;
    semilogy(t, diaP);
    title('Diagonal');
    legend('Posicao', 'Velocidade');
end



