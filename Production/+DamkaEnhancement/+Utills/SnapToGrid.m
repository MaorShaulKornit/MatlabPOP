function [pnt1,pnt2] = SnapToGrid(pnts,SqSz)

% xclear pnts

x = pnts(:,1);
y = pnts(:,2);
x = Utills.mergeClosePointsA(x,50);
y = Utills.mergeClosePointsA(y,50);

% dx = mean(diff(sort(x)));
% dy = mean(diff(sort(y)));
 nGrid = [];
for p = 1:length(x)
    for q = 1:length(y)
        nGrid = cat(1,nGrid,[x(p),y(q)]);
    end
end

pairs = Utills.bestPointPairs(pnts, nGrid, 100);
nGrid = Utills.relaxGrid(nGrid,SqSz);

pnt1 = pnts(pairs(:,1),:);
pnt2 = nGrid(pairs(:,2),:);

% [Iwarp, Dx, Dy] = warpFromPointPairs(im2, pnt2, pnt1, [1000,1000]);

% PathPlot(pnts,'k*');
% hold on
% PathPlot(nGrid,'r*');
% drawEdge([pnts(pairs(:,1),:),nGrid(pairs(:,2),:)]);

