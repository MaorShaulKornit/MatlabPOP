function Corners = getCorners(img)

img = imbinarize(rgb2gray(img));
img = imerode(img,ones(5));
K = 8;
se1 = [true(K),false(K,2*K);false(K,3*K);false(K,2*K),true(K)];
se2 = fliplr(se1);
C1 = bwhitmiss(img, se1, se2);
C2 = bwhitmiss(img, se2, se1);
Corners = C1 | C2;
end