%% Ada Görgün
function alpha = parabolic_fit(f_alpha, alpha_L, alpha_U,tolerance)

    alpha_A = alpha_L;
    alpha_B = (alpha_L + alpha_U)/2;
    alpha_C = alpha_U;

    while abs(alpha_C - alpha_B) > tolerance

        a = f_alpha(alpha_A)/((alpha_A-alpha_B)*(alpha_A-alpha_C)) + f_alpha(alpha_B)/((alpha_B-alpha_A)*(alpha_B-alpha_C)) + f_alpha(alpha_C)/((alpha_C-alpha_A)*(alpha_C-alpha_B));
        b = f_alpha(alpha_A)*(alpha_B+alpha_C)/((alpha_A-alpha_B)*(alpha_A-alpha_C)) + f_alpha(alpha_B)*(alpha_A+alpha_C)/((alpha_B-alpha_A)*(alpha_B-alpha_C)) + f_alpha(alpha_C)*(alpha_A+alpha_B)/((alpha_C-alpha_A)*(alpha_C-alpha_B));

        if a == 0
           
            a = 1e-6;   
        end

        alpha = b/(2*a);

        if alpha > alpha_B
            
            alpha_A = alpha_B;
            
        else
            
            alpha_C = alpha_B;
            
        end

        alpha_B = alpha;
        
        if alpha_B == alpha_A
            
            alpha_A = alpha_A + 1e-8;
            
        elseif alpha_B == alpha_C
            
            alpha_C = alpha_C - 1e-8;
            
        end
    end

end
