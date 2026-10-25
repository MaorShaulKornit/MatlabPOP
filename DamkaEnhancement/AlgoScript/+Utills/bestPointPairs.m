function pairs = bestPointPairs(pnt1, pnt2, maxDist)
% pnt1: Mx2
% pnt2: Nx2
% maxDist: optional maximum allowed distance (set [] for no limit)
%
% pairs: Kx2, each row is [indexInPnt1, indexInPnt2]

    if nargin < 3 || isempty(maxDist)
        maxDist = inf;
    end

    % Cost matrix: Euclidean distance between all pairs
    D = pdist2(pnt1, pnt2);

    % matchpairs solves minimum-cost one-to-one assignment
    % Unassigned cost should be larger than any valid match
    costOfNonAssignment = maxDist;

    [pairs, ~] = matchpairs(D, costOfNonAssignment);

    % Remove matches that exceed maxDist
    if ~isinf(maxDist)
        d = D(sub2ind(size(D), pairs(:,1), pairs(:,2)));
        pairs = pairs(d <= maxDist, :);
    end
end