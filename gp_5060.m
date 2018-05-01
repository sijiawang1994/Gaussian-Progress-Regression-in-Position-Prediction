

% This is a experiment for position prediction for reference within range [50,60]
% Kernel function:  Squared Exponential
% Training:         id: 0 ~ 70
% Test id:          71 ~ 96
% Result RMSE:      0.5379

datasource = csvread('slice_localization_data.csv', 1, 0);

trainingData = datasource(1:40177,:); % patient id: 0~70

% Filter data by reference in range [50,60]
trainingData5060 = find(trainingData(:,end) > 50 & trainingData(:,end) < 60);

% Training sample and training label
xTr = datasource(trainingData5060, 2:end - 1);
yTr = datasource(trainingData5060, end);

% Training
gprMdl = fitrgp(xTr,yTr,'KernelFunction', 'squaredexponential');

% Generate test data
testData = datasource(40178:end,:);
testData5060 = find(testData(:,end) > 50 & testData(:,end) < 60);
xTe = testData(testData5060, 2:end-1);
yTe = testData(testData5060, end);

% Calculate RMSE
yPred = predict(gprMdl, xTe);  
RMSE = sqrt(mean(yTe - yPred).^2);














