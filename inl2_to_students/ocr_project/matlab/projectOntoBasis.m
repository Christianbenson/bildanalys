function [r,u_p] = projectOntoBasis(im,bases)
x1 = sum(dot(im,bases(:,:,1)));
x2 = sum(dot(im,bases(:,:,2)));
x3 = sum(dot(im,bases(:,:,3)));
x4 = sum(dot(im,bases(:,:,4)));
u_p = x1*bases(:,:,1) + x2*bases(:,:,2) + x3*bases(:,:,3) + x4*bases(:,:,4);
r = sqrt(sum(dot(im-u_p,im-u_p)));
end