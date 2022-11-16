%% Ada Görgün
function y = sigmoid_prime(x) % derivative of sigmoid

y = exp(-x)./((1+exp(-x)).^2);

end