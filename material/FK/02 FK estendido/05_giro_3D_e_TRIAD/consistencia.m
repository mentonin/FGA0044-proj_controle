function [eps, eps_i] = consistencia(dx, P)
samples = length(dx);
n_states = size(P,2);
eps   = zeros(1,samples);
eps_i = zeros(samples,n_states);

for k = 1:samples
    if ndims(P) == 2
        eps(k) = dx(k,1)/P(k,1)*dx(k,1)';
        eps_i(k,1) = dx(k,1) / sqrt(P(k,1));
    else
        eps(k) = dx(k,:)/P(:,:,k)*dx(k,:)';
        for j = 1:n_states
            eps_i(k,j) = dx(k,j) / sqrt(P(j,j,k)) ;
        end
    end 
    
    %         if eps(k) > 1e3
    %             flag = 1;
    %         end
end

end

