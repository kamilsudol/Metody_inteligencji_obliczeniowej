clear; clc;

load iris_dataset;

klasa1_train = irisInputs(:,(1:45));
klasa1_test = irisInputs(:,(46:50));
klasa2_train = irisInputs(:,(51:95));
klasa2_test = irisInputs(:,(96:100));
klasa3_train = irisInputs(:,(101:145));
klasa3_test = irisInputs(:,(146:150));

train_in = [klasa1_train, klasa2_train, klasa3_train];
train_out = [repmat([1,-1,-1], length(klasa1_train), 1);repmat([-1,1,-1], length(klasa1_train), 1);repmat([1,-1,1], length(klasa1_train), 1)]';

net = linearlayer(0, 0.0001);
net = configure(net,train_in,train_out);
net = train(net,train_in,train_out);

ytest1 = net(klasa1_test);
ytest2 = net(klasa2_test);
ytest3 = net(klasa3_test);

for x = 1:length(klasa1_test)
   [~,idx] = max(ytest1(:,x));
   ytest1(idx,x) = 1;
   [~,idx] = max(ytest2(:,x));
   ytest2(idx,x) = 1;
   [~,idx] = max(ytest3(:,x));
   ytest3(idx,x) = 1;
end

accuracy = (sum(ytest1(1,:)) + sum(ytest2(2,:)) + sum(ytest3(3,:)))/15 * 100