function pnts = fixDta(x,y,img,margin)

% xclear x y img
% margin = 100;
% rng = [1,1,size(img,1),size(img,2)];
pnts = [x,y];
pnts = pnts(pnts(:,1)>margin,:);
pnts = pnts(pnts(:,2)>margin,:);
pnts = pnts(pnts(:,1)<size(img,2)-margin,:);
pnts = pnts(pnts(:,2)<size(img,1)-margin,:);
pnts = Utills.mergeClosePointsA(pnts,30);
% imshow(img)
% hold on
% PathPlot(pnts,'r*')
