clc
clear all

% im1 = imread([cd,'\P1\Production_0_3_4_24p06.bmp']);
% im2 = imread([cd,'\P1\Production_500_3_4_12176p31.bmp']);
% 
% im1 = imread([cd,'\WBXDI4\Production_0_3_4_14p98.bmp']);
% im2 = imread([cd,'\WBXDI4\Production_1000_3_4_16218p40.bmp']);

im1 = imread([cd,'\WithFabric2\Production_0_1_4_24p06.bmp']);
im2 = imread([cd,'\WithFabric2\Production_168_1_4_4107p11.bmp']);

% im1 = imread([cd,'\P3\Production_0_3_4_32p28.bmp']);
% im2 = imread([cd,'\P3\Production_372_3_4_12087p38.bmp']);
% 
% % im1 = imread([cd,'\P5\Production_0_3_4_27p30.bmp']);
% % im2 = imread([cd,'\P5\Production_435_3_4_12110p59.bmp']);
% 
% 
% im1 = imread([cd,'\P6\Production_0_3_4_14p98.bmp']);
% im2 = imread([cd,'\P6\Production_250_3_4_4065p96.bmp']);
% 
im11 = Utills.getwarpedFull(im1,1);
im22 = Utills.getwarpedFull(im2,1);
% im11 = imread([cd,'\SE3\1.tif']);
% im22 = imread([cd,'\SE3\2.tif']);

%%
% G1  = normalized(rgb2gray(im11));
% BW = G1>0.6;
% S = sum(BW,2);
% S1 = S > 0.5*max(S);
% S1 = bwareafilt(S1,1);
% y1 = mean(find(S1));
% %%
% G1  = normalized(rgb2gray(im22));
% BW = G1>0.6;
% S = sum(BW,2);
% S1 = S > 0.5*max(S);
% S1 = bwareafilt(S1,1);
% y2 = mean(find(S1));
%% WithFabric2
y1 = 1503;
y2 = 1734;

p1 = 24.06;
p2 = 4107.11;
%% WithFabric
y1 = 983;
y2 = 937;

p1 = 32.28;
p2 = 16170.50;
%% WBXDI4
y1 = 1193;
y2 = 1476;

p1 = 14.98;
p2 = 16218.4;

%% P1
y1 = 1193;
y2 = 1476;

p1 = 14.98;
p2 = 16218.4;

%% P2
y1 = 261;
y2 = 468;

p1 = 24.54;
p2 = 12176.72;

%% P3
y1 = 1523;
y2 = 1247;

p1 = 32.28;
p2 = 12087.38;
%% P4
y1 = 1069;
y2 = 1024;

p1 = 31.94;
p2 = 16170.27;
%% P5
y1 = 462;
y2 = 326;

p1 = 27.30;
p2 = 12110.59;
%% P6
y1 = 908;
y2 = 978;

p1 = 14.98;
p2 = 16218.40;
%%
BSz = 4036.8;

% dImages = p2-p1;
dLines = pix2mm(y2-y1,127);

format long
% T = (dImages-dLines)/4
p2-(p1+dLines + BSz*1)

%%
% pos1 = 

%%

imshow2(im11,im22)