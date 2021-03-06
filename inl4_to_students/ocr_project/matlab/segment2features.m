function x = segment2features(B)
B = double(B);
[x1,y1] = meshgrid(1:size(B,2), 1:size(B,1));
weightedx1 = x1 .* B;
weightedy1 = y1 .* B;
xcentre = sum(weightedx1(:)) / sum(B(:));
ycentre = sum(weightedy1(:)) / sum(B(:));
xcentre = floor(xcentre);
ycentre = floor(ycentre);
%sum of pixels in center of mass row
feature1 = sum(B(ycentre, 1:size(B,2)));

%sum of pixels in center of mass column
feature2 = sum(B(1:size(B,1), xcentre));

%sum of nonzero pixels in the image
feature3 = nnz(B);

%Differentiation, edge detection
maskMatrix = [0 ,1, 0;
             1, -4, 1;
             0 ,1, 0];
C = conv2(B,maskMatrix);
C = abs(C);

[x2,y2] = meshgrid(1:size(C,2), 1:size(C,1));
weightedx2 = x2 .* C;
weightedy2 = y2 .* C;
xcentre = sum(weightedx2(:)) / sum(C(:));
ycentre = sum(weightedy2(:)) / sum(C(:));
xcentre = floor(xcentre);
ycentre = floor(ycentre);


%feature 4,5,6 is the same as 1,2,3 except its done with the derivative of
%the image

feature4 = sum(C(ycentre, 1:size(C,2)));
feature5 = sum(C(1:size(C,1), xcentre));
feature6 = nnz(C);

%Attempt at using zoning-algorithm to get features
gridSize = 5;
zoneFeatures = zeros(16,1);
zoneFeatures2 = zeros(16,1);
k = 1;
[Y X] = size(B);
if(ycentre > Y - 1 - 2*gridSize) 
    ycentre = Y - 1 - 2*gridSize;
elseif(ycentre < 1 + 2*gridSize)
    ycentre = 1 + 2*gridSize;
end

if(xcentre > X - 1 - 2*gridSize)
    xcentre = X - 1 - 2*gridSize;
elseif(xcentre < 1 + 2*gridSize)
    xcentre = 1 + 2*gridSize;
end

for i = -2:1
    for j = -2:1
        zoneFeatures(k) = sum(sum(B(ycentre+i*gridSize:ycentre+(i+1)*gridSize, xcentre+j*gridSize:xcentre+(j+1)*gridSize)));
        zoneFeatures2(k) = sum(sum(C(ycentre+i*gridSize:ycentre+(i+1)*gridSize, xcentre+j*gridSize:xcentre+(j+1)*gridSize)));
        k = k+1;
    end
end

x = [feature1;feature2;feature3;feature4;feature5;feature6;zoneFeatures;zoneFeatures2];