clear; clc;

load iris_dataset;

klasa1_train = irisInputs(:,(1:45));
klasa1_test = irisInputs(:,(46:50));
klasa2_train = irisInputs(:,(51:95));
klasa2_test = irisInputs(:,(96:100));
klasa3_train = irisInputs(:,(101:145));
klasa3_test = irisInputs(:,(146:150));

train_in = [klasa1_train, klasa2_train, klasa3_train];
train_out = [repmat([-1,1], length(klasa1_train), 1);repmat([1,-1], length(klasa1_train), 1);repmat([1,1], length(klasa1_train), 1)]';

net = linearlayer(0, 0.0001);
net = configure(net,train_in,train_out);
for i = 1 : 1
   net = train(net,train_in,train_out); 
end


ytest1 = round(net(klasa1_test))';
ytest2 = round(net(klasa2_test))';
ytest3 = round(net(klasa3_test))';

ok = 0;

for i=1:5
   if ytest1(i,1) == -1 &&  ytest1(i,2) == 1
        ok = ok + 1;
   end
   if ytest2(i,1) == 1 &&  ytest2(i,2) == -1
        ok = ok + 1;
   end
   if ytest3(i,1) == 1 &&  ytest3(i,2) == 1
        ok = ok + 1;
   end
   
end

accuracy = ok/15 * 100

