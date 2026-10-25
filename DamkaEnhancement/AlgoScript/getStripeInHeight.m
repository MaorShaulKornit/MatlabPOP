function Img = getStripeInHeight(F,DB,isDebug,DebugDir)
if nargin == 2
    isDebug = false;
    DebugDir = [];
end
Nms = struct2table(cellfun(@Utills.getPOPNameInfo,F.imgNames));
Nms1 = sortrows(Nms,'CamID');
Nms1 = sortrows(Nms1,'ImgInd');

PropImg = F.getImageByName(Nms1.Input(1));
im1 = Utills.myRealFishEye(PropImg.getImage,-0.022);
PropImg = F.getImageByName(Nms1.Input(2));
im2 = Utills.myRealFishEye(PropImg.getImage,-0.022);
PropImg = F.getImageByName(Nms1.Input(3));
im3 = Utills.myRealFishEye(PropImg.getImage,-0.022);
PropImg = F.getImageByName(Nms1.Input(4));
im4 = Utills.myRealFishEye(PropImg.getImage,-0.022);

Iwarp1 = Utills.applyDistortion(im1,DB.Hn.im1.dX,DB.Hn.im1.dY);
Iwarp2 = Utills.applyDistortion(im2,DB.Hn.im2.dX,DB.Hn.im2.dY);
Iwarp3 = Utills.applyDistortion(im3,DB.Hn.im3.dX,DB.Hn.im3.dY);
Iwarp4 = Utills.applyDistortion(im4,DB.Hn.im4.dX,DB.Hn.im4.dY);
Img = Utills.applyMargins(Iwarp1,Iwarp2,Iwarp3,Iwarp4,DB.Hn.Margins,0);
if isDebug
    PImage.SaveAsPNG(Iwarp1,'Iwarp1',127,DebugDir);
    PImage.SaveAsPNG(Iwarp2,'Iwarp2',127,DebugDir);
    PImage.SaveAsPNG(Iwarp3,'Iwarp3',127,DebugDir);
    PImage.SaveAsPNG(Iwarp4,'Iwarp4',127,DebugDir);
end

end
    