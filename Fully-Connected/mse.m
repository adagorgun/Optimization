%% Ada G�rg�n
function out = mse(y_true, y_pred) 
    
    out = 0.5*sum((y_true - y_pred).^2);
    
end