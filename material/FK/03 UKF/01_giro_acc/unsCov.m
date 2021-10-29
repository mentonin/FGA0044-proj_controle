function P = unsCov(noMean1, noMean2, peso)
n = size(noMean1,2);
P = peso(1)*(noMean1(:,1)*noMean2(:,1)') + peso(2)*(noMean1(:,2:n)*noMean2(:,2:n)');

end
