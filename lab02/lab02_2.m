clear; clc;

amount = 5;

klasa1 = randn(amount, 2) + [2, 0];
klasa2 = randn(amount, 2) + [-2, 0];
klasa3 = randn(amount, 2) + [0, 2];
klasa4 = randn(amount, 2) + [0, -2];

x_train = [klasa1; klasa2; klasa3; klasa4]';
y_train = [repmat([1,-1,-1,-1], amount, 1); repmat([-1,1,-1,-1], amount, 1); repmat([-1,-1,1,-1], amount, 1); repmat([-1,-1,-1,1], amount, 1)]';

net = linearlayer(0, 0.01);
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

for x = 1:length(klasa1_test')
   [~,idx] = max(y_test1(:,x));
   y_test1(idx,x) = 1;
   [~,idx] = max(y_test2(:,x));
   y_test2(idx,x) = 1;
   [~,idx] = max(y_test3(:,x));
   y_test3(idx,x) = 1;
   [~,idx] = max(y_test4(:,x));
   y_test4(idx,x) = 1;
end

accuracy = (sum(y_test1(1,:)) + sum(y_test2(2,:)) + sum(y_test3(3,:)) + sum(y_test4(4,:)))/40