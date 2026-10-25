clc
clear all

Nm = 'Production_471_2_4_11471p91.bmp';

T = getPOPNameInfo(Nm);
im1 = imread([cd,'\AfterCorrectionV3.8\Production_21_2_4_534p86.bmp']);
im2 = imread([cd,'\AfterCorrectionV3.8\',Nm]);
im11 = getCalibratedFrame(im1,2,4);
im22 = getCalibratedFrame(im2,2,4);
%%
y1 = pix2mm(307,127);
y2 = pix2mm(104,127);
p1 = 97.4;
p2 = T.Distance;
% BSz = 4036.8;
pnt1 = p1-y1;
pnt2 = p2-y2;
d = round((pnt2-pnt1)*100)

%%
figure 
imshow(im22)
title(['FramePos = ',num2str(p2)])

% 2*BSz-d
%%