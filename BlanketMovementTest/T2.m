clc
clear all


T = [];

for kk = 1:5
F1 = folderTree(['P',num2str(kk)]);
cam = 3;
A = struct2table(cellfun(@getPOPNameInfo,F1.imgNames));
A = A(A.CamID==cam,:);
x(kk) = A.Distance(1);
for p = 1:size(A,1)
im1 = F1.getImageByName(A.Input(p)).getImage;
im11 = Utills.getwarpedFull(im1,cam);
G1  = normalized(rgb2gray(im11));
BW = G1>0.6;
S = sum(BW,2);
S1 = S > 0.5*max(S);
S1 = bwareafilt(S1,1);
[y] = find(S1);
y1(p) = mean(y);
end
y11 = pix2mm(y1,127);
dy1 = diff(y11);
dP1 = diff(A.Distance);
T = cat(2,T,sum(dP1'-dy1));
end
plot(x,T,'*')