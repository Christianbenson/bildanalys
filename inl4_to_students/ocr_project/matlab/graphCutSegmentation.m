clf
close all
clear all
load('heart_data.mat')

sigma_background = std(background_values);
mu_background = mean(background_values);

sigma_chamber = std(chamber_values);
mu_chamber = mean(chamber_values);

subplot(2,1,1)
imshow(im)

I = double(im);
[M N] = size(I);
n = M*N;

mu0 = mu_background;
mu1 = mu_chamber;
lambda = 0.1;

Neighbours = edges4connected(M,N);
i = Neighbours(:,1);
j = Neighbours(:,2);
A = sparse(i,j,lambda,n,n);

T = [ (I(:)-mu1).^2 (I(:)-mu0).^2];
T = sparse(T);

tic
[E Theta] = maxflow(A,T);
Theta = reshape(Theta,M,N);
Theta = double(Theta);
toc

subplot(2,1,2)
imshow(Theta)