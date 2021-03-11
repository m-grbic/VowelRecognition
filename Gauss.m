function [f] = Gauss(X, M, S)

    n = length(M);
    
    f = 1/((2*pi)^(n/2)*(det(S))^(0.5))*exp(-0.5*(X-M)'/S*(X-M));

end