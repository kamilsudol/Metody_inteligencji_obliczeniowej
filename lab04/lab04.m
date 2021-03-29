clear;clc;

data1 = fopen('Lab5_training.txt', 'r');
data2 = fopen('Lab5_testing.txt', 'r');

training_data = fscanf(data1, '%f', [7 Inf])';
testing_data = fscanf(data2, '%f', [7 Inf])';

trainin = training_data(:, 1:4)';
trainout = training_data(:, 5:7)';

testin = testing_data(:, 1:4)';
valid_testout = testing_data(:, 5:7);

net = feedforwardnet([12 6]);
net.divideFcn = 'dividetrain';
net.layers{1}.transferFcn = 'logsig';
net.trainParam.epochs = 500;
net = configure(net, trainin, trainout);

net = train(net, trainin, trainout);

testout = round(net(testin))';

valid = 0;
for x = 1:length(testout)
    check = 0;
    for y = 1:3
        if testout(x,y) == valid_testout(x, y)
            check = check + 1;
        end
    end
    if check == 3
        valid = valid + 1;
    end
end

accuracy = valid/length(testout) * 100