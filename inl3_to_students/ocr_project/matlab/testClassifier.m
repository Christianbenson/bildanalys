clear all

load('FaceNonFace.mat');
part = cvpartition(200,'HoldOut',0.20);
Xtrain = X(:,part.training);
Ytrain = Y(:,part.training);
classification_data = class_train(Xtrain,Ytrain);
training_index = part.training;

Xtest = X(:,part.test);
Ytest = Y(:,part.test);
errorstest = 0;
errorstrain = 0;
totals = 0;

for i = 1:40
    y = classifyFace(Xtest(:,i), classification_data);
    if y ~= Ytest(:,i)
        errorstest = errorstest + 1;
    end
    totals = totals + 1;
end

errorstest
totals

for i = 1:160
    y = classifyFace(Xtrain(:,i), classification_data);
    if y ~= Ytrain(:,i)
        errorstrain = errorstrain + 1;
    end
    totals = totals + 1;
end

errorstrain