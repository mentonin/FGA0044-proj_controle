P = P_k.Data;
t = P_k.Time;

for ii = 1:length(P)
    %traceP(ii) = trace(P(:,:,ii));
    %eigP(:,ii) = eig(P(:,:,ii));
    diaP(:,ii) = diag(P(:,:,ii));
end
figure;
%semilogy(t, traceP);
%title('Trace');
%figure;
%semilogy(t, eigP);
%title('Autovalores');
%figure;
semilogy(t, diaP);
title('Diagonal');
legend('\alpha', 'q', '\theta');




