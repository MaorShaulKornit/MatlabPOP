function [Dx, Dy] = warpFromPointPairs(I, pnt1, pnt2, outSize ,Acc)
% I     : input image (grayscale or single channel)
% pnt1  : Mx2 source points  [x y]
% pnt2  : Mx2 target points  [x y]
% outSize: [rows cols] of output image. If omitted, same as input.

    if nargin < 4 || isempty(outSize)
        outSize = [size(I,1), size(I,2)];
    end

    pnt1 = double(pnt1);
    pnt2 = double(pnt2);

    % Sparse displacement at the control points
    d = pnt2 - pnt1;   % [dx dy]

    % Output grid
    [Xq, Yq] = meshgrid(1:Acc:outSize(2), 1:Acc:outSize(1));

    % Interpolate displacement field over the whole image
    % Use pnt2 as the "destination" locations for inverse warping
    Fx = scatteredInterpolant(pnt2(:,1), pnt2(:,2), d(:,1), 'linear', 'linear');
    Fy = scatteredInterpolant(pnt2(:,1), pnt2(:,2), d(:,2), 'linear', 'linear');

    Dx = Fx(Xq, Yq);
    Dy = Fy(Xq, Yq);
    
    % Inverse mapping: where to sample from in the source image
%     Xsrc = Xq - Dx;
%     Ysrc = Yq - Dy;

    % Sample the image
%     Iwarp = interp2(double(I), Xsrc, Ysrc, 'linear', 0);
end