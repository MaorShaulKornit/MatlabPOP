function Img = getStripeInHeight(Props,DB,isDebug,DebugDir)
if nargin == 2
    isDebug = false;
    DebugDir = [];
end

im1 = DamkaEnhancement.Utills.myRealFishEye(Props(1).getImage,-0.022);
im2 = DamkaEnhancement.Utills.myRealFishEye(Props(2).getImage,-0.022);
im3 = DamkaEnhancement.Utills.myRealFishEye(Props(3).getImage,-0.022);
im4 = DamkaEnhancement.Utills.myRealFishEye(Props(4).getImage,-0.022);

Iwarp1 = DamkaEnhancement.Utills.applyDistortion(im1,DB.Hn.im1.dX,DB.Hn.im1.dY);
Iwarp2 = DamkaEnhancement.Utills.applyDistortion(im2,DB.Hn.im2.dX,DB.Hn.im2.dY);
Iwarp3 = DamkaEnhancement.Utills.applyDistortion(im3,DB.Hn.im3.dX,DB.Hn.im3.dY);
Iwarp4 = DamkaEnhancement.Utills.applyDistortion(im4,DB.Hn.im4.dX,DB.Hn.im4.dY);
Img = DamkaEnhancement.Utills.applyMargins(Iwarp1,Iwarp2,Iwarp3,Iwarp4,DB.Hn.Margins,0);
if isDebug
    PImage.SaveAsPNG(Iwarp1,'Iwarp1',127,DebugDir);
    PImage.SaveAsPNG(Iwarp2,'Iwarp2',127,DebugDir);
    PImage.SaveAsPNG(Iwarp3,'Iwarp3',127,DebugDir);
    PImage.SaveAsPNG(Iwarp4,'Iwarp4',127,DebugDir);
end

end
    