%% Ada Görgün  Three Point Equal Interval
function alpha = three_point_equal_interval(f, alpha_L, alpha_U, tolerance, x, d)

    error = inf;
    f_alpha = @(alpha) f(x + alpha*d);
    
    while error > tolerance
                
        delta = alpha_U - alpha_L;
        alpha_1 = alpha_L + delta/4;
        alpha_2 = alpha_1 + delta/4;
        alpha_3 = alpha_2 + delta/4;
        
        f_alpha_1 = feval(f_alpha, alpha_1);
        f_alpha_2 = feval(f_alpha, alpha_2);
        f_alpha_3 = feval(f_alpha, alpha_3);
        
        
        if f_alpha_1 < f_alpha_2
            
            if f_alpha_1 < f_alpha_3
                
                alpha_U = alpha_2;
                
            elseif f_alpha_3 < f_alpha_1
                
                alpha_L = alpha_2;

            else
                
                disp('Could not find with this method');
            
            end
            
        elseif f_alpha_2 < f_alpha_1
            
            
            if f_alpha_3 <= f_alpha_2
                
                alpha_L = alpha_2;
                
            else 
                
                alpha_L = alpha_1;
                alpha_U = alpha_3;
                
            end
            
        else
            
            if f_alpha_2 < f_alpha_3
                
                alpha_U = alpha_3;
                
                
            elseif f_alpha_3 < f_alpha_2
                
                alpha_L = alpha_2;
                
            else
                
                disp('Could not find with this method');
                
                
            end
            
        end
        
        error =  abs(alpha_U - alpha_L);
        
    end

    alpha = (alpha_U + alpha_L)/2;

end