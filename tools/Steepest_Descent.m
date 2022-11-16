%% Ada Görgün   Steepest Descent

function x_curr = Steepest_Descent(grad, x_init, epsilon_x, epsilon_g, max_iter, one_dimensional_search)

    x_curr = x_init;
    
    for i = 1:max_iter
        
        x_old = x_curr;
        
        g = feval(grad, x_old)';
        fs(i) = f(x_old);
        
        if norm(g) <= epsilon_g
            disp('Gradient norm is less than epsilon_g: ');
            disp(epsilon_g);
            break
        end
        
        %% Select One Dimensional Search
        
        tolerance = 1e-4;
        
        d = -g;
                
        alpha_L = 0;
        alpha_U = 0.1;
        
        if one_dimensional_search == 1 % Golden Search
            
            alpha = GoldenSection_alpha(@f, alpha_L, alpha_U, tolerance, x_old, d);
            
        elseif one_dimensional_search == 2 % 3-Interval Equal Search

            alpha = three_point_equal_interval(@f, alpha_L, alpha_U, tolerance, x_old, d);
            
        elseif one_dimensional_search == 3 % Parabolic Fit
            
            f_alpha = @(alpha) f(x_old + alpha*d);
            
            alpha = parabolic_fit(f_alpha, alpha_L, alpha_U, tolerance);
            
        elseif one_dimensional_search == 4 % Dichotomous search
            
            alpha = DichotomousMethod_alpha(@f, alpha_L, alpha_U, tolerance, x_old, d);
            
        elseif one_dimensional_search == 5  % Secant Method
            
            alpha = SecantMethod_alpha(@g, x_old, d);
            
        elseif one_dimensional_search == 6  % Fibonacci Method
            
            alpha = FibonacciSearch_alpha(@f, alpha_L, alpha_U, tolerance, x_old, d);
            
        elseif one_dimensional_search == 7  % Newtons Search
            
            alpha = NewtonSearch_alpha(@g, x_old, d);
            
        end
        
        
        x_curr = x_old + alpha*d;
        
        if norm(x_curr - x_old) <= epsilon_x
            
            disp('Norm difference between two iterations is less than epsilon_x: ');
            disp(epsilon_x);
            break;
            
        end

    end
    
    figure, plot(fs), title('Objective function');


end