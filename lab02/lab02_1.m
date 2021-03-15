clear; clc;

amount = 5;

klasa1 = randn(amount, 2) + [2, 0];
klasa2 = randn(amount, 2) + [-2, 0];
klasa3 = randn(amount, 2) + [0, 2];
klasa4 = randn(amount, 2) + [0, -2];

x_train = [klasa1; klasa2; klasa3; klasa4]';
y_train = [repmat([1,0,0,0], amount, 1); repmat([0,1,0,0], amount, 1); repmat([0,0,1,0], amount, 1); repmat([0,0,0,1], amount, 1)]';

net = perceptron;
net = configure(net,x_train,y_train);
net = train(net, x_train , y_train);

klasa1_test = randn(1000, 2) + [2, 0];
klasa2_test = randn(1000, 2) + [-2, 0];
klasa3_test = randn(1000, 2) + [0, 2];
klasa4_test = randn(1000, 2) + [0, -2];

y_test1 = net(klasa1_test');
y_test2 = net(klasa2_test');
y_test3 = net(klasa3_test');
y_test4 = net(klasa4_test');


accuracy = (sum(y_test1(1,:)) + sum(y_test2(2,:)) + sum(y_test3(3,:)) + sum(y_test4(4,:)))/40