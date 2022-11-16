%% Ada Görgün  Q7-code implemented for Part b is used in Part c
clear all; close all; clc;

%% Create Training data
x_train = -2 + 5*rand(3000,1);
y_train = f_true(x_train)';

%% Create Network [10 30 20 10 1]
net = Network();
net.add(FCLayer(1,10));
net.add(SigmoidLayer());
net.add(FCLayer(10,30));
net.add(SigmoidLayer());
net.add(FCLayer(30,20));
net.add(SigmoidLayer());
net.add(FCLayer(20,10));
net.add(SigmoidLayer());
net.add(FCLayer(10,1));
net.add(SigmoidLayer());

%% Train with Steepest Descent
net.fit(x_train, y_train, 1000, 0.15);

%% Create Testing Data
x_test = linspace(-2, 3, 400);
y_test = f_true(x_test);

%% Obtain Prediction from the Trained Network
y_pred = net.predict(x_test);

figure;
plot(y_test); hold on; plot(y_pred); xlabel('x'); ylabel('f(x)');
legend('True Function', 'Predicted Function');

test_err = mse(y_test, y_pred');






