clc
clear all

Nm1 = 'Production_24_1_4_607p25.bmp';
Nm2 = 'Production_192_1_4_4690p55.bmp';
T1 = getPOPNameInfo(Nm1);
T2 = getPOPNameInfo(Nm2);
im1 = imread([cd,'\Drift1\',Nm1]);
im2 = imread([cd,'\Drift1\',Nm2]);
im11 = getCalibratedFrame(im1,1,4);
im22 = getCalibratedFrame(im2,1,4);
%%
y1 = pix2mm(199,127);
y2 = pix2mm(432,127);
p1 = T1.Distance;
p2 = T2.Distance;
% BSz = 4036.8;
pnt1 = p1-y1;
pnt2 = p2-y2;
d = round((pnt2-pnt1)*100)

% 2*BSz-d
%%