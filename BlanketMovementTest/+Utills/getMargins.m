function Margins = getMargins(im1,im2,im3,im4)
pnts1 = getCPoints(im1);
pnts2 = getCPoints(im2);
pnts3 = getCPoints(im3);
pnts4 = getCPoints(im4);
P21 = getDPoints(pnts1);
P22 = getDPoints(pnts2);
P23 = getDPoints(pnts3);
P24 = getDPoints(pnts4);
[pos12,pos21] = findPairs(P21,P22);
[pos23,pos32] = findPairs(P22,P23);
[pos34,pos43] = findPairs(P23,P24);

BoundingPos = [pnts1(:,2);pnts2(:,2);pnts2(:,2);pnts2(:,2)];

Margins.pos12 = pos12;
Margins.pos21 = pos21;
Margins.pos23 = pos23;
Margins.pos32 = pos32;
Margins.pos34 = pos34;
Margins.pos43 = pos43;
Margins.H1 = min(BoundingPos);
Margins.H2 = max(BoundingPos);
end