%% Ada Görgün  Fibonacci Search for finding step-size
function alpha = FibonacciSearch_alpha(f, alpha_L, alpha_U, tolerance, x, d)

    F(1) = 1;
    N = 0;
    epsilon = 0.05;
    delta = alpha_U - alpha_L;
    
    
    while F(N + 1) < (1 + 2*epsilon)*delta/tolerance
        
        N = N + 1;
        
        if N == 1
            
            F(N + 1) = F(N) + 1;
            
        else
            
            F(N + 1) = F(N) + F(N - 1);
            
        end
    end
        
    
    for i = 1:N
        
        
        if i == N
            
            rho = 0.5;
            delta = alpha_U - alpha_L;
            
            alpha_L1 = alpha_L + (rho - epsilon)*delta;
            alpha_U1 = alpha_L + (1 - rho)*delta;

            f_L1 = feval(f, x + alpha_L1*d);
            f_U1 = feval(f, x + alpha_U1*d);
            
            
        else
            
            rho = 1 - F(N - i + 1)/F(N - i + 2);
            delta = alpha_U - alpha_L;
            
            alpha_L1 = alpha_L + rho*delta;
            alpha_U1 = alpha_L + (1 - rho)*delta;

            f_L1 = feval(f, x + alpha_L1*d);
            f_U1 = feval(f, x + alpha_U1*d);
            
        end
        
        if f_L1 < f_U1
            
            alpha_U = alpha_U1;
            
        elseif f_U1 < f_L1
            
            alpha_L = alpha_L1;
            
        else
            
            alpha_L = (alpha_L1 + alpha_U1)/2;
            alpha_U = alpha_L;
            
        end
        
    end
    
    alpha = (alpha_L + alpha_U)/2;

end