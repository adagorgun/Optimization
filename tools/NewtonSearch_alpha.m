%% Ada Görgün  Newton Search for finding step-size
function alpha = NewtonSearch_alpha(grad, x, d)

    maxIter = 100;
    tolerance = 1e-4;
    
    alpha = 0.001;
    alpha_k = 0;
    
    f_xinit = feval(grad, x + alpha_k*d)*d;
    
    f_xk = f_xinit;
    i = 0;
    
    while abs(f_xk) > tolerance*abs(f_xinit)
        
        i = i + 1;
        alpha_old = alpha_k;
        alpha_k = alpha;
        
        f_xk_previous = f_xk;
        f_xk = feval(grad, x + alpha_k*d)*d;
        
        alpha = (f_xk*alpha_old - f_xk_previous*alpha_k)/(f_xk - f_xk_previous);
        
        if (i >= maxIter) 
            break
        end
        
    end

end