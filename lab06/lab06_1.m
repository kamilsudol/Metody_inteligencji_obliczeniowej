clear; clc;

my_fuzzy = readfis('lab06');
raw_data = readtable('lab7_data.csv');

train_amount = height(raw_data)*0.8;

train = raw_data(1:train_amount,:);
train = train{:,:};
test = raw_data(train_amount+1:height(raw_data),:);
test = test{:,:};

% opt = genfisOptions('GridPartition');
% opt.NumMembershipFunctions = [3 5 3];
% opt.InputMembershipFunctionType = ["gaussmf" "trimf" "gaussmf"];

opt = genfisOptions('SubtractiveClustering');
opt.ClusterInfluenceRange = 0.1;
opt.DataScale = [0 0 0 0; 5 5 5 5];

fis = genfis(train(:,1:3), train(:,4:4), opt);
ymodel = evalfis(fis,train(:,1:3));
ymodel_test = evalfis(fis,test(:,1:3));

ymodel_myfuzzy = evalfis(my_fuzzy,train(:,1:3));
ymodel_test_myfuzzy = evalfis(my_fuzzy,test(:,1:3));

error_train = immse(ymodel, train(:,4:4));
error_test = immse(ymodel_test, test(:,4:4));

error_train_myfuzzy = immse(ymodel_myfuzzy, train(:,4:4));
error_test_myfuzzy = immse(ymodel_test_myfuzzy, test(:,4:4));
% fuzzy
% showrule(fis_train)
% fis_test = genfis(test(:,1:3), test(:,4:4), opt);
% fis_train(test(:,1:3))