%% Ada Görgün
function out = mse_prime(y_true, y_pred)  % derivative of mse
    
    out = (y_pred - y_true)/length(y_pred);
    
end