%% Ada Görgün  Secant Seach
function alpha = SecantMethod_alpha(grad, x, d)

    epsilon = 1e-4; 
    max_Iter = 100; 
    
    alpha_old = 0;
    alpha_curr = 0.001;
    
    df_alpha_old = feval(grad,x + alpha_old*d)*d;
    df_alpha_curr = feval(grad,x + alpha_curr*d)*d;
    
    i = 0;
    
    while abs(df_alpha_curr) > epsilon*abs(df_alpha_old)
                        
        alpha = (df_alpha_curr*alpha_old - df_alpha_old*alpha_curr)/(df_alpha_curr - df_alpha_old);
        
        i = i + 1;
        
        alpha_old = alpha_curr;
        alpha_curr = alpha;
        df_alpha_old = df_alpha_curr;
        df_alpha_curr = feval(grad,x + alpha_curr*d)*d;
        
        if (i >= max_Iter) 
            break;
        end
        
    end 
    
    

end