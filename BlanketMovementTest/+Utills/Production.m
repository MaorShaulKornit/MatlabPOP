clc
clear all


dmka1 = imread([cd,'\DamkaFiles\TestSnapshot202606071510_0_1_4_0p0.bmp']);
dmka2 = imread([cd,'\DamkaFiles\TestSnapshot202606071510_0_2_4_0p0.bmp']);
dmka3 = imread([cd,'\DamkaFiles\TestSnapshot202606071510_0_3_4_0p0.bmp']);
dmka4 = imread([cd,'\DamkaFiles\TestSnapshot202606071510_0_4_4_0p0.bmp']);
d = 100;
[dX1,dY1] = getDistortionMap(dmka1,d);
[dX2,dY2] = getDistortionMap(dmka2,d);
[dX3,dY3] = getDistortionMap(dmka3,d);
[dX4,dY4] = getDistortionMap(dmka4,d);

Iwarp1 = applyDistortion(dmka1,dX1,dY1);
Iwarp2 = applyDistortion(dmka2,dX2,dY2);
Iwarp3 = applyDistortion(dmka3,dX3,dY3);
Iwarp4 = applyDistortion(dmka4,dX4,dY4);


%%
Margins = getMargins(Iwarp1,Iwarp2,Iwarp3,Iwarp4);
im = applyMargins(Iwarp1,Iwarp2,Iwarp3,Iwarp4,Margins,50);
