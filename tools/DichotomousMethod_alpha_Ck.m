%% Ada Görgün 
function alpha = DichotomousMethod_alpha_Ck(f, alpha_L, alpha_U, tolerance, x, d, Ck)

epsInterval = 1e-5;

N = ceil(log((alpha_U-alpha_L)/tolerance)/log(2));


for i = 1:N

    mid = (alpha_L + alpha_U)/2;

    alpha_L1 = mid - epsInterval;
    alpha_U1 = mid + epsInterval;

    f_L1 = f(x + alpha_L1*d, Ck);
    f_U1 = f(x + alpha_U1*d, Ck);

    if f_L1 < f_U1

        alpha_U = alpha_U1; 


    elseif f_U1 < f_L1

        alpha_L = alpha_L1;

    else

        alpha_L = alpha_L1;
        alpha_U = alpha_U1;

    end


end

alpha = (alpha_L + alpha_U)/2;

end