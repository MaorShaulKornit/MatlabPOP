function [pos1,pos2] = findPairs(P21,P22)
% xclear P21 P22


D = pdist2(P21(:,2),P22(:,2)) < 25;
[a,b] = find(D);
[~,pairs] = max([P21(a,1)-P22(b,1)]);

pos1 = P21(a(pairs),1);
pos2 = P22(b(pairs),1);
