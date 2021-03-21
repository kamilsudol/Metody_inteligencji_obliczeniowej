clear; clc;

amount = 5;

klasa1 = randn(amount, 2) + [2, 0];
klasa2 = randn(amount, 2) + [-2, 0];
klasa3 = randn(amount, 2) + [0, 2];
klasa4 = randn(amount, 2) + [0, -2];

x_train = [klasa1; klasa2; klasa3; klasa4]';
y_train = [repmat([-1,1], amount, 1); repmat([1,1], amount, 1); repmat([1,-1], amount, 1); repmat([-1,-1], amount, 1)]';

net = linearlayer(0, 0.001);
net = configure(net,x_train,y_train);
net = train(net, x_train , y_train);

klasa1_test = randn(1000, 2) + [2, 0];
klasa2_test = randn(1000, 2) + [-2, 0];
klasa3_test = randn(1000, 2) + [0, 2];
klasa4_test = randn(1000, 2) + [0, -2];

y_test1 = round(net(klasa1_test')');
y_test2 = round(net(klasa2_test')');
y_test3 = round(net(klasa3_test')');
y_test4 = round(net(klasa4_test')');

klasa1 = klasa1';
klasa2 = klasa2';
klasa3 = klasa3';
klasa4 = klasa4';
hold on
plot(klasa1(1:1,:),klasa1(2:2,:),'bs')
plot(klasa2(1:1,:),klasa2(2:2,:),'r+')
plot(klasa3(1:1,:),klasa3(2:2,:),'go')
plot(klasa4(1:1,:),klasa4(2:2,:),'m*')
linehandle = plotpc(net.IW{1},net.b{1});
hold off

ok = 0;

for i=1:1000
   if y_test1(i,1) == -1 &&  y_test1(i,2) == 1
        ok = ok + 1;
   end
   if y_test2(i,1) == 1 &&  y_test2(i,2) == 1
        ok = ok + 1;
   end
   if y_test3(i,1) == 1 &&  y_test3(i,2) == -1
        ok = ok + 1;
   end
   if y_test4(i,1) == -1 &&  y_test4(i,2) == -1
        ok = ok + 1;
   end
end

accuracy = ok/40

