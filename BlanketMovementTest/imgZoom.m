function im3 = imgZoom(im,T)
% im = getIm.Barca;
% T = 1.05;
if T==1
    im3 = im;
    return
end
Sz = size(im,1:2);
Sz2 = round(Sz.*T);
Dlta = floor((Sz2-Sz)/2);
im2 = imresize(im,T);
im3 = im2(Dlta(1):Dlta(1)+Sz(1)-1,Dlta(2):Dlta(2)+Sz(2)-1,:);
