function dmka2 = myRealFishEye(dmka1,k)
I = im2double(dmka1);
[h,w,~] = size(I);
cx = w/2;
cy = h/2;
invScale = 2/min(w,h);
[X,Y] = meshgrid(1:w,1:h);
xn = (X - cx) * invScale;
yn = (Y - cy) * invScale;
r2 = xn.^2 + yn.^2;
scale = 1 + k * r2;
xs = (cx + (xn .* scale) / invScale);
ys = (cy + (yn .* scale) / invScale);
Iout = zeros(size(I));
for ch = 1:size(dmka1,3)
    V = I(:,:,ch);
%     interp2 assumes 1..w (X) and 1..h (Y) default grid
    Ic = interp2(V, xs, ys, 'linear', 0); % fill out-of-bounds with 0 (black)
    Iout(:,:,ch) = Ic;
end
dmka2 = im2uint8(Iout);
end