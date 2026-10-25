
%%
clc
clear all

F1 = folderTree('P1');
F2 = folderTree('P2');
F3 = folderTree('P3');



q = 1;
cam = 2;
for n = [0,1,2,3]
p = cam+4*n;
im1 = F1.images(p).getImage;
im2 = F2.images(p).getImage;

im11 = Utills.getwarpedFull(im1,cam);
im22 = Utills.getwarpedFull(im2,cam);

G1  = normalized(rgb2gray(im11));
BW = G1>0.6;
BW = bwareafilt(BW,1);
[y,~] = find(BW);
y1(q) = mean(y);

G2  = normalized(rgb2gray(im22));
BW = G2>0.6;
BW = bwareafilt(BW,1);
[y,~] = find(BW);
y2(q) = mean(y);
q = q+1;
end

% y1 = pix2mm(y1,127);
% y2 = pix2mm(y2,127);

% dy = y2-y1;
% dy = dy-dy(1);

y11 = pix2mm(y1,127);
dy1 = diff(y11);
P1 =   [24.06,4107.11,8093.01,12176.31];
dP1 = diff(P1);
% T1 = sum();
T2 = dP1-dy1

y22 = pix2mm(y2,127);
dy2 = diff(y22);
P2 =   [24.54,4107.46,8093.29,12176.72];
dP2 = diff(P2);
% T2 = sum();
T1 = dP2-dy2

T22 = T2-T2(1);
T11 = T1-T1(1);
T22-T11

%%





