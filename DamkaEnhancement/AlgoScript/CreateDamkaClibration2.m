function DB = CreateDamkaClibration2()
F1 = folderTree('DamkaFiles\2.5');
Nms1 = struct2table(cellfun(@Utills.getPOPNameInfo,F1.imgNames));
Nms1 = sortrows(Nms1,'CamID');
d = 100;

DB.H1.Height = 2.5;
for p = 1:size(Nms1,1)
    PropImg = F1.getImageByName(Nms1.Input(p));
    CImg = PropImg.getImage;
    CImg = Utills.myRealFishEye(CImg,-0.022);
    [dX,dY] = Utills.getDistortionMap(CImg,d);
    img = Utills.applyDistortion(CImg,dX,dY);
    for t = 1:1
        [dX1,dY1] = Utills.getDistortionMap(img,d);
        dX = Utills.applyDistortion(dX,dX1,dY1);
        dY = Utills.applyDistortion(dY,dX1,dY1);
        img = Utills.applyDistortion(CImg,dX,dY);
    end
    DB.H1.(['im',num2str(p)]).dX = dX;
    DB.H1.(['im',num2str(p)]).dY = dY;
    DB.H1.(['im',num2str(p)]).Warped = img;
end
DB.H1.Margins = Utills.getMargins(DB.H1.im1.Warped,DB.H1.im2.Warped,DB.H1.im3.Warped,DB.H1.im4.Warped);

DB.H2.Height = 5;
F2 = folderTree('DamkaFiles\5.0');
Nms1 = struct2table(cellfun(@Utills.getPOPNameInfo,F2.imgNames));
Nms1 = sortrows(Nms1,'CamID');
d = 100;
for p = 1:size(Nms1,1)
    PropImg = F2.getImageByName(Nms1.Input(p));
    CImg = PropImg.getImage;
    CImg = Utills.myRealFishEye(CImg,-0.022);
    [dX,dY] = Utills.getDistortionMap(CImg,d);
    img = Utills.applyDistortion(CImg,dX,dY);
    for t = 1:1
        [dX1,dY1] = Utills.getDistortionMap(img,d);
        dX = Utills.applyDistortion(dX,dX1,dY1);
        dY = Utills.applyDistortion(dY,dX1,dY1);
        img = Utills.applyDistortion(CImg,dX,dY);
    end
    DB.H2.(['im',num2str(p)]).dX = dX;
    DB.H2.(['im',num2str(p)]).dY = dY;
    DB.H2.(['im',num2str(p)]).Warped = img;
end
DB.H2.Margins = Utills.getMargins(DB.H2.im1.Warped,DB.H2.im2.Warped,DB.H2.im3.Warped,DB.H2.im4.Warped);