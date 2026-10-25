clc
clear all
tic
DB = CreateDamkaClibration2();
toc
%%
% remove Images from DB
for hnum = 1:2
    for imnum = 1:4
        DB.(['H',num2str(hnum)]).(['im',num2str(imnum)]).Warped = [];
    end    
end
save DB DB
%% Add Height 4mm to DB
load DB
DB = AddHight(DB,4);
%% DamkaImages Heigt 4mm
F4 = folderTree(['DamkaFiles\4.0']);
Img = getStripeInHeight(F4,DB);
%% ImageFiles 
F4 = folderTree('ImgFiles\S5');
Img = getStripeInHeight(F4,DB);
%%
imshow(Img)
showSeperationLines(DB,10);
%%
PImage.SaveAsPNG(Img,'H',127)