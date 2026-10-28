clc
clear all
%% init
DB = getDB;
load CalibData

%% Load Images 4 at a time
xclear CalibData DB
CalibData = DamkaEnhancement.AddHight(CalibData,DB.Hight);
F = POPSnapshots(DB.PreciseSnapshots);
%% get stiched (LR).
xclear CalibData DB F
Row1 = F.getRow(0);
ImgStart = DamkaEnhancement.getStripeInHeight(Row1.Props,CalibData);
dStart = Row1.getDist;
%%
DB = AddLimits(ImgStart,DB);
%% 

ShowSplited(ImgStart,DB)

%% stich distance (UD).
xclear CalibData DB F Row1 ImgStart dStart
Img1 = ImgStart;
d1 = dStart;
Steps = [0,6,12,18,24,30];
L = length(Steps);
c = 0;
for p = 2:L
Row2 = F.getRow(Steps(p));
Img2 = DamkaEnhancement.getStripeInHeight(Row2.Props,CalibData);
d2 = Row2.getDist;
d = d2-d1+c;
d1 = d2;
Tot = mm2pix_rounded(d,127);
c = d-pix2mm(Tot,127);
Img1 = [Img2(1:Tot,:,:);Img1];
end
% imshow(Img1)
%%
ShowSplited(Img1,DB)
linkaxes

%% split to "threads"
%% Akaze drtection
%% placement
%% output
