%% Ada Görgün
function y_true = f_true(x)

for i = 1:length(x)

    if x(i)<=0 && x(i)>=-2
        y_true(i) = -x(i)*(x(i)+2);
    elseif x(i)>0 && x(i)<1
        y_true(i) = 1;
    elseif x(i)>=1 && x(i)<=3
        y_true(i) = (x(i)-1)*(x(i)-3)+1;
    else
        y_true(i) = 0;
    end 
end

end