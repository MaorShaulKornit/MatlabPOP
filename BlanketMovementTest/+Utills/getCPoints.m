function pnts = getCPoints(imA)

img = imbinarize(rgb2gray(imA));
frame = [100,100];
r1 = 15;
r2 = 45;
r3 = 50;
se1 = bwcircle(frame,r1);
se2 = bwcircle(frame,r3) & ~bwcircle(frame,r2);
img2 = bwhitmiss(img,se1,se2);
[y, x] = find(img2);
pnts = fixDta(x,y,img2,25);
end