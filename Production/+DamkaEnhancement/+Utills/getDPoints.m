function P2 = getDPoints(pnts1)
[P1,~] = sortrows(pnts1,1);
P11 = diff(P1(:,1));

P12 = P11<2;
P2 = [];
for p = 1:size(P12,1)
    if P12(p)
        if P1(p,2)<P1(p+1,2)
            P2 = cat(1,P2,P1(p,:));
        else
            P2 = cat(1,P2,P1(p+1,:));
        end
    end
end

% P2 = pnts1(id(P12),:);

% pos = mergeClosePoints(P2(:,1),110);
% pos = pos(:,1);



end
