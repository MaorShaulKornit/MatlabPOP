function Margins = getMargins(im1,im2,im3,im4)
pnts1 = Utills.getCPoints(im1);
pnts2 = Utills.getCPoints(im2);
pnts3 = Utills.getCPoints(im3);
pnts4 = Utills.getCPoints(im4);
P21 = Utills.getDPoints(pnts1);
P22 = Utills.getDPoints(pnts2);
P23 = Utills.getDPoints(pnts3);
P24 = Utills.getDPoints(pnts4);
[pos12,pos21] = Utills.findPairs(P21,P22);
[pos23,pos32] = Utills.findPairs(P22,P23);
[pos34,pos43] = Utills.findPairs(P23,P24);

% BoundingPos = [pnts1(:,2);pnts2(:,2);pnts2(:,2);pnts2(:,2)];
% pnts1(:,2)


Margins.pos12 = pos12;
Margins.pos21 = pos21;
Margins.pos23 = pos23;
Margins.pos32 = pos32;
Margins.pos34 = pos34;
Margins.pos43 = pos43;
Margins.H11 = round(min(pnts1(:,2)));
Margins.H12 = round(max(pnts1(:,2)));
Margins.H21 = round(min(pnts2(:,2)));
Margins.H22 = round(max(pnts2(:,2)));
Margins.H31 = round(min(pnts3(:,2)));
Margins.H32 = round(max(pnts3(:,2)));
Margins.H41 = round(min(pnts4(:,2)));
Margins.H42 = round(max(pnts4(:,2)));


eqD = 250;
if Margins.pos12 > size(im1,2) - eqD
    d = eqD  + Margins.pos12 - size(im1,2);
    Margins.pos12 = Margins.pos12 - d;
    Margins.pos21 = Margins.pos21 - d;
end

if Margins.pos21 < eqD
    d = eqD - Margins.pos21;
    Margins.pos12 = Margins.pos12 + d;
    Margins.pos21 = Margins.pos21 + d;
end

if Margins.pos23 > size(im2,2) - eqD
    d = eqD  + Margins.pos22 - size(im2,2);
    Margins.pos23 = Margins.pos23 - d;
    Margins.pos32 = Margins.pos32 - d;
end

if Margins.pos32 < eqD
    d = eqD - Margins.pos32;
    Margins.pos23 = Margins.pos23 + d;
    Margins.pos32 = Margins.pos32 + d;
end


if Margins.pos34 > size(im3,2) - eqD
    d = eqD  + Margins.pos34 - size(im3,2);
    Margins.pos34 = Margins.pos34 - d;
    Margins.pos43 = Margins.pos43 - d;
end

if Margins.pos43 < eqD
    d = eqD - Margins.pos43;
    Margins.pos34 = Margins.pos34 + d;
    Margins.pos43 = Margins.pos43 + d;
end

Margins.total = round(Margins.pos12 + (Margins.pos23-Margins.pos21) + (Margins.pos34-Margins.pos32) + (size(im4,2)-Margins.pos43));
end