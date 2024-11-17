
clear
error(1) = 1.0;
error(2) = 1.0;

% function for right hand side
f = @(x)(-6*pi*cos(3*pi*x) + 9*pi*pi*x.*sin(3*pi*x));

% SOR with the new optimal relaxation parameter
for solver = 3  % Focusing on SOR here
    
    % loop over number of nodes
    for k = 2:8
        % nodes and mesh width
        N = 2^k;
        h = 1 / N;

        % prepare sparse matrix
        A = (1 / h^2) * spdiags([-ones(N-1, 1), 2*ones(N-1, 1), -ones(N-1, 1)], -1:1, N-1, N-1);

        % condition number (if needed)
        s = sprintf("estimate of the condition number %f", condest(A));
        disp(s);

        % nodes
        x = h:h:1-h;

        % right-hand side
        b = f(x);

        % compute optimal omega based on the corrected formula
        omega_opt = 2 / (1 + sin(pi * h));
        s3 = sprintf('SOR by component, omega_opt=%f, N=%d', omega_opt, N);
        disp(s3);

        % initialize solution and count iterations
        u = zeros(size(b));
        iter_count = 0;

        for iter = 1:1000
            iter_count = iter_count + 1;
            for i = 1:length(u)
                u(i) = (1 - omega_opt) * u(i) + omega_opt * (b(i) - A(i, :) * u) / A(i, i);
            end
            if norm(A * u - b') < 1e-6
                break;
            end
        end
        fprintf('Iterations: %d for N=%d
', iter_count, N);
        
        % Record iteration counts for analysis
    end
end
