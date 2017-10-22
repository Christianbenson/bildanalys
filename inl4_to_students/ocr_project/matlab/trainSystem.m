%Load image
load('ocrsegments.mat');

for i = 1:100
    
    X(:,i) = segment2features(S{1,i})
    
end
classification_data = class_train(X,y)