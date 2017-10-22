clf
clear all

%Load measurement data
load('linjepunkter.mat');

%   Plot data in figure 1, transpose data to be able to solve with 
%   backslash command. Plot least square line in same window
figure(1)
plot(x,y,'+');
A = ones([2,20]);
A(1,:) = x;
A = A.';
Y = y.';
p = A\Y;
hold on
x1 = linspace(-0.1,0.5,100);
fx = p(1)*x1 + p(2);
plot(x1,fx)
hold off

figure(2)
plot(x,y,'+');
N = 20;
xsquaresum = sum(x.^2);
ysquaresum = sum(y.^2);
xsum = sum(x);
ysum = sum(y);
A = zeros(2,2);
A(1,1) = xsquaresum - (1/N)*xsum*xsum;
A(1,2) = xsum * ysum - (1/N)*xsum*ysum;
A(2,1) = xsum * ysum - (1/N)*xsum*ysum;
A(2,2) = ysquaresum - (1/N)*ysum*ysum;
[vecs,vals] = eig(A)
a1 = vecs(1,1)
b1 = vecs(2,1)
c = -1/N*(a1*xsum + b1*ysum)
fx1 = ((a1*x1) + c)/(-vecs(2,1));
hold on
plot(x1,fx1)
fx2 = (vecs(1,2).*x1)/(-vecs(2,2)) - 1/N.*(vecs(1,2)*xsum + vecs(2,2)*ysum)/(-vecs(2,2));
plot(x1,fx2)