function nGridN = relaxGrid(nGrid,dSz)
% xclear nGrid

nGridN = nGrid;
Ux = sort(unique(nGrid(:,1)));
Uy = sort(unique(nGrid(:,2)));
dx = diff(Ux);
dy = diff(Uy);
cx = cumsum(repmat(dSz,size(dx)));
cy = cumsum(repmat(dSz,size(dy)));

Rx = repmat(Ux(1),size(Ux));
Rx(2:end) = Rx(2:end) + cx;
Ry = repmat(Uy(1),size(Uy));
Ry(2:end) = Ry(2:end) + cy;

for p = 1:length(Ux)
    nGridN(nGridN(:,1)==Ux(p),1) = Rx(p);
end
for p = 1:length(Uy)
    nGridN(nGridN(:,2)==Uy(p),2) = Ry(p);
end
