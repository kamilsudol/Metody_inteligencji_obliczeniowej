clear; clc;

data = fopen('dane.txt', 'r');
A = fscanf(data, '%f', [4 Inf])';

x_train = A(:,1:3)';
y_train = A(:,4)';

net = perceptron;
net=configure(net,x_train,y_train);
net = train(net, x_train , y_train);

out = net([0.111; -9.345; 1.999])