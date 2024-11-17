
clear
error(1) = 1.0;
error(2) = 1.0;

% function for right hand side
f = @(x)(-6*pi*cos(3*pi*x) + 9*pi*pi*x.*sin(3*pi*x));

% loop over the solvers
% 1 - direct solver
% 2 - damped Jacobi
% 3 - SOR (by component)
% 4 - SOR (with matrix-vector)
for solver = 1:4

    % assign the number of damping parameters
    switch solver
        case 1
            % direct solver
            no_damp_par = 1;
        case 2
            % damped Jacobi
            no_damp_par = 11;
        case {3, 4}
            % SOR
            no_damp_par = 1;  % Only one parameter needed since we calculate the optimal omega
    end

    % loop over the damping parameters
    for no_damp = 1:no_damp_par
        % assign the damping parameter
        omega = no_damp / 10.0;
        
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

            % compute solution
            switch solver
                case 1
                    s1 = sprintf('direct solver, omega=%f, N=%d', omega, N);
                    disp(s1);
                    u = A\b'; % Direct solution

                case 2
                    s2 = sprintf('damped Jacobi, omega=%f, N=%d', omega, N);
                    disp(s2);
                    u = zeros(size(b));
                    for iter = 1:1000
                        u_new = (1 - omega) * u + omega * (b - A * u) ./ diag(A);
                        if norm(u_new - u) < 1e-6
                            break;
                        end
                        u = u_new;
                    end

                case 3
                    % Compute optimal omega for SOR
                    rho = max(abs(eig(A)));
                    omega_opt = 2 / (1 + sqrt(1 - rho^2));
                    
                    s3 = sprintf('SOR by component, omega_opt=%f, N=%d', omega_opt, N);
                    disp(s3);
                    u = zeros(size(b));
                    for iter = 1:1000
                        for i = 1:length(u)
                            u(i) = (1 - omega_opt) * u(i) + omega_opt * (b(i) - A(i, :) * u) / A(i, i);
                        end
                        if norm(A * u - b') < 1e-6
                            break;
                        end
                    end

                case 4
                    % Compute optimal omega for SOR
                    rho = max(abs(eig(A)));
                    omega_opt = 2 / (1 + sqrt(1 - rho^2));
                    
                    s4 = sprintf('SOR matrix-vector, omega_opt=%f, N=%d', omega_opt, N);
                    disp(s4);
                    u = zeros(size(b));
                    for iter = 1:1000
                        u_new = u;
                        for i = 1:length(u)
                            u_new(i) = (1 - omega_opt) * u(i) + omega_opt * (b(i) - A(i, :) * u_new) / A(i, i);
                        end
                        if norm(u_new - u) < 1e-6
                            break;
                        end
                        u = u_new;
                    end
            end
            % Optional: store error values or other calculations here
        end
    end
end
