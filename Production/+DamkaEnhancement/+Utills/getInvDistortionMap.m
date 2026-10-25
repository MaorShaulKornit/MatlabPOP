function [dX,dY] = getInvDistortionMap(dmka,d)
Corners = getCorners(dmka);
[y, x] = find(Corners);
pnts = fixDta(x,y,dmka,25);
[pnt1,pnt2] = SnapToGrid(pnts,d);
Sz = size(dmka);
Acc = 45;
[Dx, Dy] = warpFromPointPairs(dmka, pnt2, pnt1, Sz, Acc);
[Xq, Yq] = meshgrid(1:Sz(2), 1:Sz(1));
% [X1,Y1] = meshgrid(1:Acc:Sz(2),1:Acc:Sz(1));
[X1,Y1] = meshgrid(linspace(1,Sz(2),size(Dx,2)),linspace(1,Sz(1),size(Dx,1)));
dX1 = X1 - Dx;
dY1 = Y1 - Dy;
dX = interp2(X1,Y1,dX1,Xq, Yq,'linear',0);
dY = interp2(X1,Y1,dY1,Xq, Yq,'linear',0);  
end