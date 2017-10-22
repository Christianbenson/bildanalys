clear all
load('femfel.mat')
bild1 = 0.2989*femfel1(:,:,1) + 0.5870*femfel1(:,:,2) + 0.1140*femfel1(:,:,3);
bild2 = 0.2989*femfel2(:,:,1) + 0.5870*femfel2(:,:,2) + 0.1140*femfel2(:,:,3);
subplot(2,2,1)
imagesc(femfel1)
subplot(2,2,2)
imagesc(femfel2)
colormap(gray)

diffMatrix = abs(bild2 - bild1);
diffMatrix = medfilt2(diffMatrix, [12 12]);

for i = 1:371
    for k = 1:455
        
        if(diffMatrix(i,k) < 50)
            diffMatrix(i,k) = 0;
        else
            diffMatrix(i,k) = 1;
        end
    end
end
subplot(2,2,3)
imagesc(diffMatrix)