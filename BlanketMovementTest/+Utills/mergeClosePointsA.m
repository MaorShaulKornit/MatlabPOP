function pntOut = mergeClosePointsA(pnt, d)
%MERGECLOSEPOINTS Merge nearby points.
%
%   pntOut = mergeClosePoints(pnt, d)
%
%   pnt : Nx2 array of (x,y) coordinates
%   d   : merge distance
%
%   Points whose distance is <= d are merged into a single point whose
%   coordinates are the average of all merged points.

    if isempty(pnt)
        pntOut = zeros(0,2);
        return;
    end

    % Pairwise distance matrix
    D = pdist2(pnt, pnt);

    % Adjacency matrix
    A = D <= d;
    A(1:size(A,1)+1:end) = true;    % self connections

    % Connected components
    G = graph(A);
    idx = conncomp(G);

    % Average each component
    nComp = max(idx);
    pntOut = zeros(nComp,2);

    for k = 1:nComp
        pntOut(k,:) = mean(pnt(idx==k,:),1);
    end
end