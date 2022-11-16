%% Ada Görgün
function alpha = BisectionMethod_alpha(f, alpha_L, alpha_U, tolerance, x, d)


    f_alpha = @(alpha) f(x + alpha*d);
    maxIter = ceil(log(tolerance/2)/log(1/2));
    
    if maxIter > 60
        
        maxIter = 60;
        
    end
    
    limit = 1e-6;
    
    df_dx = @(x) (f_alpha(x+limit)-f_alpha(x))/limit;
    
    for i = 1:maxIter
        
        alpha_M = (alpha_L + alpha_U)/2;
        
        if df_dx(alpha_M) > tolerance
            
            alpha_U = alpha_M;
            
        else
            
            alpha_L = alpha_M;
            
        end
        
    end
    
    alpha = alpha_M;

end