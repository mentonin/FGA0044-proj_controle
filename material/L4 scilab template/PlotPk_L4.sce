P = Pk.values;
t = Pk.time;
total = max(size(t));
for ii = 1:total
    diaP(:,ii) = diag(P(:,:,ii));
end
//figure;
semilogy(t, diaP');
title('Diagonal de Pk');
legend('$\alpha$', '$q$', '$\theta$');
