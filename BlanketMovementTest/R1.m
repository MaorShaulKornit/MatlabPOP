clc
clear all

F = folderTree('G:\KornitProjects\PreciseStuff\Night shift - 27.09.26\imagedebug');
imID = 158;
% F = folderTree('G:\results_resChange_pop\126.95');
N = [];
for p = 2:length(F.images)
    N = cat(1,N,{F.images(p).Name});
end
ind = cellfun(@getImReradyInd,N);
[~,pos] = sort(ind);
N = N(pos);
THight = 0;
for p = 3:imID
    T = F.getImageByName(N{p});
    THight = THight + T.Height;
end
THight_mm = pix2mm(THight,300)

P1 = F.getImageByName(N{3});
P2 = F.getImageByName(N{imID});
im1 = P1.getImage;
im2 = P2.getImage;



im1 = imcomplement(im1(:,:,1:3));
im2 = imcomplement(im2(:,:,1:3));


imshow((im2(:,4500:4500+5000,1:3)))
title(['Img Pos In mm = ',num2str(THight_mm)])
%%
y1 = pix2mm(166,300);
y2 = pix2mm(547,300);
% BSz = 4181.4;


d = round(THight_mm - y2 - pix2mm(size(im1,1),300)+y1,3)
d = round(d*100)
%%
img = [];
for p = 2:5
    T = F.getImageByName(N{p});
    T1 = T.getImage;
    img = cat(1,T1(:,:,1:3),img);
end
imshow(img)