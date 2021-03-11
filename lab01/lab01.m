clear;clc;

% net = perceptron;
% view(net);
% net;
% net=configurate(net,x,y);
% view(net);
% net = train(net, x , y);
% x_test, y_test;
% y_out = net(x_test);
% 
% %badamy accuracy oraz blad

amount = 5;

label0 = randn(2, amount);
label1 = randn(2, amount);

for x = 1:length(label1)
   label1(1:1,x) = label1(1:1,x) + 2;
   label1(2:2,x) = label1(2:2,x) + 2;
end
% plot(label0(1:1,:),label0(2:2,:),'*');
% plot(label1(1:1,:),label1(2:2,:),'*');
y_t0 = ones(1,amount);
y_t1 = zeros(1,amount);
x_train = [label0, label1];
y_train = [y_t0, y_t1];

net = perceptron;
net=configure(net,x_train,y_train);
net = train(net, x_train , y_train);


test1 = randn(2, 1000);
test2 = randn(2, 1000);

for x = 1:length(test2)
   test2(1:1,x) = test2(1:1,x) + 2;
   test2(2:2,x) = test2(2:2,x) + 2;
end

y_out1 = net(test1);
y_out2 = net(test2);

accuracy = (sum(y_out1(:)== 1) + sum(y_out2(:)== 0))/(2*length(test1))*100