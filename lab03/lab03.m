clear; clc;

amount = 100;
test_amount = 25;

a = 0; b = 10;

x = linspace(a, b, amount);

P = x;
T = fx(x);

net = feedforwardnet(round(.25*amount));
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'purelin';
net = configure(net, P, T);
net = train(net, P, T);

test_x = linspace(a, b, test_amount);
valid_y = fx(test_x);

test_y = net(test_x);
aproksymacja = net.LW{2,1}.*purelin(test_x);

hold on
plot(x, fx(x), '-x');
plot(test_x, test_y, '*');
plot(test_x, aproksymacja, 'o');
hold off

mse = (1/test_amount)*sum((valid_y - test_y).^2)

function y = fx(x)
    A = 20; B = 4.5; C = .5; D = 10; E = 3; F = 1;
    y = A*sin(B*x+C) + D*cos(E*x+F);
end