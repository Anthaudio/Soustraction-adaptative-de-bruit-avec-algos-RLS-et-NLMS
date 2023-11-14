function [w, y, e] = algoms_RLS(x, d, order, alpha, lambda)

    % Initialisation
    N = length(x);
    y = zeros(N, 1);
    w = zeros(order, 1);
    S = alpha * eye(order); 
    e = zeros(N, 1);

    % Hérédité
    for n = order:N

        k = (1/lambda) * 1 / (1 + (1/lambda) * x(n-order+1:n)' * S * x(n-order+1:n)) * S * x(n-order+1:n);
        e(n) = w' * x(n-order+1:n) - d(n);
        w = w - e(n) * k;
        S = (1/lambda) * S - (1/lambda) * k * x(n-order+1:n)' * S;
        y(n) = x(n-order+1:n)' * w;

    end
end
