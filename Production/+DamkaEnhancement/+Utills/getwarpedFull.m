function img1 = getwarpedFull(img,N)


dir = [cd,'\DamkaFiles\TestSnapshot202606071510_0_',num2str(N),'_4_0p0.bmp'];
dmka1 = imread(dir);
d = 100;
[dX1,dY1] = Utills.getDistortionMap(dmka1,d);
img1 = Utills.applyDistortion(img,dX1,dY1);
end