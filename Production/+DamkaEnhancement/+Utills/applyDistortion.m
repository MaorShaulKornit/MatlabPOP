function Iwarp = applyDistortion(img,dX,dY)

Sz = size(img);
Iwarp = zeros(Sz);
for p = 1:size(img,3)
    Iwarp(:,:,p) = interp2(im2double(img(:,:,p)), dX, dY, 'linear', 0);
end
end