%% Ada Görgün  Golden Section Search for finding step-size
function alpha = GoldenSection_alpha(f, alpha_L, alpha_U, tolerance, x, d)

    rho = (3 - sqrt(5))/2;
    N = ceil(log(tolerance/(alpha_U-alpha_L))/log(1-rho));
    
    delta = alpha_U - alpha_L;

    alpha_L1 = alpha_L + rho*delta;
    alpha_U1 = alpha_L + (1 - rho)*delta;

    f_L1 = feval(f, x + alpha_L1*d);
    f_U1 = feval(f, x + alpha_U1*d);
    
    for i = 1:N

        if f_L1 < f_U1

            alpha_U = alpha_U1; 
            delta = alpha_U - alpha_L;

            alpha_L1 = alpha_L + rho*delta;       
            alpha_U1 = alpha_L + (1 - rho)*delta;

            f_L1 = feval(f, x + alpha_L1*d);
            f_U1 = feval(f, x + alpha_U1*d);

        elseif f_U1 < f_L1

            alpha_L = alpha_L1;

            delta = alpha_U - alpha_L;

            alpha_L1 = alpha_L + rho*delta;       
            alpha_U1 = alpha_L + (1 - rho)*delta;

            f_L1 = feval(f, x + alpha_L1*d);
            f_U1 = feval(f, x + alpha_U1*d);

        else

            alpha_L = (alpha_L1 + alpha_U1)/2;
            alpha_U = alpha_L;

        end

    end
    
    alpha = (alpha_L + alpha_U)/2;

end