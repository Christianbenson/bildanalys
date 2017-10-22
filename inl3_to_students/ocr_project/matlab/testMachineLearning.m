clear all

load('ocrfeaturestrain.mat');


%Transposing matrices for usage in pre-coded algorithms
X = X.';
Y = Y.';
index = 1;
part = cvpartition(45,'HoldOut',0.95);

%Looking for only A's and B's, so sorts anything else out.
for i = 1:size(Y,1)
    if Y(i,1) == 1 
        sortedX(index,:) = X(i,:);
        sortedY(index,1) = Y(i,1);
        index = index + 1;
    
    elseif Y(i,1) == 2
        sortedX(index,:) = X(i,:);
        sortedY(index,1) = Y(i,1);
        index = index + 1;
    end
end

xTrain = sortedX(part.training,:);
yTrain = sortedY(part.training,:);
xTest = sortedX(part.test,:);
yTest = sortedY(part.test,:);

% Testing regression tree classifier
tree = fitctree(xTrain,yTrain);
error = 0;

for i = 1:part.TestSize
    label = predict(tree, xTest(i,:));
    if label ~= yTest(i,:)
        error = error + 1;
    end
end
treeSuccessRate = 1 - (error ./ part.NumObservations)

% Testing state vector machine
SVMModel = fitcsvm(xTrain,yTrain);
error = 0;

for i = 1:part.TestSize
    label = predict(SVMModel, xTest(i,:));
    if label ~= yTest(i,:)
        error = error + 1;
    end
end
SVMModelSuccessRate = 1 - (error ./ part.NumObservations)

% Testing nearest neighbour classifier
mdl = fitcknn(xTrain,yTrain);
error = 0;

for i = 1:part.TestSize
    label = predict(mdl, xTest(i,:));
    if label ~= yTest(i,:)
        error = error + 1;
    end
end
mdlSuccessRate = 1 - (error ./ part.NumObservations)