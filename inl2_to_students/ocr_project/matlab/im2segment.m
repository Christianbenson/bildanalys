function [S] = im2segment(im)
% [S] = im2segment(im)

nrofsegments = 5;
m = size(im,1);
n = size(im,2);
threshold = 200;
segmentationIndex = 1;
pixelsFoundInSegment = 0;
for kk = 1:nrofsegments;
    temp = zeros(m,n);
    for i = segmentationIndex:n
        sumOfColumn = 0;
        for j = 1:m
            if(neighbourHoodCheck(im,i,j,threshold))
                temp(j,i) = 1;
                sumOfColumn = sumOfColumn + 1;
            else
                temp(j,i) = 0;
            end
        end
        if sumOfColumn > 0
            pixelsFoundInSegment = pixelsFoundInSegment+1;
        end
        if sumOfColumn < 1 && pixelsFoundInSegment > 1;
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
        if(row -1 >= 0)
            if(matrix(row-1,column) < threshold)
                neighbours = neighbours + 1;
            end
        end
        if(row+1 <= size(matrix,1))
            if(matrix(row+1,column) < threshold)
                neighbours = neighbours +1;
            end
        end
        if(column -1 >= 0)
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
