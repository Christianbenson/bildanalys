
sumOfError=0;
figureNumber = 1;
for i = 1:2 % Both of the two sets of images
    for j = 1:3 % For all the three bases
        figure
        colormap(gray)
        subplot(2,2,1)
        imagesc(bases{j}(:,:,1))
        subplot(2,2,2)
        imagesc(bases{j}(:,:,2))
        subplot(2,2,3)
        imagesc(bases{j}(:,:,3))
        subplot(2,2,4)
        imagesc(bases{j}(:,:,4))
        for k = 1:400
            [error, projection] = projectOntoBasis(stacks{i}(:,:,k),bases{j});
            sumOfError = sumOfError + error;
            if mod(k,100) == 0
                figure
                title(i)
                imagesc(projection)
                colormap(gray)
            end
        end
        meanOfError = sumOfError/400
        sumOfError = 0;
    end
end