function [S] = im2segment(im)

I = double(im)/255;
[M N] = size(I);
n = M*N;

mu_background = 0.1;
mu_letter = 0.9;

mu0 = mu_background;
mu1 = mu_letter;
lambda = 0.001;

Neighbours = edges4connected(M,N);
i = Neighbours(:,1);
j = Neighbours(:,2);
A = sparse(i,j,lambda,n,n);

T = [ (I(:)-mu1).^2 (I(:)-mu0).^2];
T = sparse(T);

[E Theta] = maxflow(A,T);
Theta = reshape(Theta,M,N);
im = double(Theta);

nrofsegments = 5;
threshold = 0.5;
segmentationIndex = 1;
pixelsFoundInSegment = 0;
for kk = 1:nrofsegments
    temp = zeros(M,N);
    for i = segmentationIndex:N
        sumOfColumn = 0;
        for j = 1:M
            if(im(j,i)==0) %neighbourHoodCheck(im,i,j,threshold)
                temp(j,i) = 1;
                sumOfColumn = sumOfColumn + 1;
            else
                temp(j,i) = 0;
            end
        end
        if sumOfColumn > 0
            pixelsFoundInSegment = pixelsFoundInSegment+1;
        end
        if sumOfColumn < 1 && pixelsFoundInSegment > 1
            pixelsFoundInSegment = false;
            segmentationIndex = i+1;
            break
        end
    end
    S{kk} = temp;
end
function [foo] = neighbourHoodCheck(matrix, column, row, threshold)
    neighbours = 0;
    if(matrix(row,column) < threshold)
        if(row-1 > 0)
            if(matrix(row-1,column) < threshold)
                neighbours = neighbours + 1;
            end
        end
        if(row+1 <= size(matrix,1))
            if(matrix(row+1,column) < threshold)
                neighbours = neighbours +1;
            end
        end
        if(column-1 > 0)
            if(matrix(row,column-1) < threshold)
                neighbours = neighbours + 1;
            end
        end
        if(column+1 <= size(matrix,2))
            if(matrix(row,column+1) < threshold)
                neighbours = neighbours +1;
            end
        end
    end
    foo = neighbours >= 2;