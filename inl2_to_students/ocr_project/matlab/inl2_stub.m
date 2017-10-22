datadir = '../datasets/short1';

a = dir(datadir);

file = 'im2';

fnamebild = [datadir filesep file '.jpg'];
fnamefacit = [datadir filesep file '.txt'];

bild = imread(fnamebild);
fid = fopen(fnamefacit);
facit = fgetl(fid);
fclose(fid);

%Letter is Z
S = im2segment(bild);
B = S{1};
imshow(B)
A = segment2features(B)

%Letter is A
B = S{2};
D = segment2features(B)
imshow(bild)

