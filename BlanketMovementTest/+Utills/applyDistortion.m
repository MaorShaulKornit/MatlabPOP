function Iwarp = applyDistortion(img,dX,dY)

Sz = size(img);
Iwarp = zeros(Sz);
for p = 1:size(img,3)
    Iwarp(:,:,p) = normalized(interp2(double(img(:,:,p)), dX, dY, 'linear', 0));
end
end