function [w, y, e] = algoms_nLMS(x, d, P, mu)

    % Initialisation
    N = length(x);
    w = zeros(P, 1); 
    e = zeros(N, 1);
    y = zeros(N, 1);

    % Hérédité
    for n = P:N

        x_actual = x(n:-1:n-P+1);
        y(n) = w' * x_actual;
        e(n) = d(n) - y(n);
        w = w + (mu/(norm(x_actual)^2)) * e(n) * x_actual;  
        
    end
end
