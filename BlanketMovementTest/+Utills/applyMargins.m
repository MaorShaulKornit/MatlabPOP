function im = applyMargins(im1,im2,im3,im4,Margins,Blur)
if nargin < 5
    Blur = 0;
end
if Blur==0
    imA = im1(Margins.H1:Margins.H2,1:ceil(Margins.pos12),:);
    imB = im2(Margins.H1:Margins.H2,floor(Margins.pos21)+1:ceil(Margins.pos23),:);
    imC = im3(Margins.H1:Margins.H2,floor(Margins.pos32)+1:ceil(Margins.pos34),:);
    imD = im4(Margins.H1:Margins.H2,floor(Margins.pos43)+1:end,:);
    im = [imA,imB,imC,imD];
else
    imA = im1(Margins.H1:Margins.H2,1:Margins.pos12-Blur,:);
    
    imA2 = im1(Margins.H1:Margins.H2,Margins.pos12-Blur+1:Margins.pos12+Blur,:);
    imB1 = im2(Margins.H1:Margins.H2,Margins.pos21-Blur+1:Margins.pos21+Blur,:);
    imAB = GradImg(imA2,imB1,Blur);
    
    imB = im2(Margins.H1:Margins.H2,Margins.pos21+Blur+1:Margins.pos23-Blur,:);
    imB2 = im2(Margins.H1:Margins.H2,Margins.pos23-Blur+1:Margins.pos23+Blur,:);
    imC1 = im3(Margins.H1:Margins.H2,Margins.pos32-Blur+1:Margins.pos32+Blur,:);    
    imBC = GradImg(imB2,imC1,Blur);
    
    imC = im3(Margins.H1:Margins.H2,Margins.pos32+Blur+1:Margins.pos34-Blur,:);
    imC2 = im3(Margins.H1:Margins.H2,Margins.pos34-Blur+1:Margins.pos34+Blur,:);
    imD1 = im4(Margins.H1:Margins.H2,Margins.pos43-Blur+1:Margins.pos43+Blur,:); 
    imCD = GradImg(imC2,imD1,Blur);
    
    imD = im4(Margins.H1:Margins.H2,Margins.pos43+Blur+1:end,:);
    im = [imA,imAB,imB,imBC,imC,imCD,imD];
end
end
function Gim = GradImg(im1,im2,Blur)

% x = linspace(-8,8,2*Blur-2);
% s = 1./(1+exp(-x));
% s = [0,s,1];
s = linspace(0,1,2*Blur);
X = repmat(s,[size(im1,1),1]);
% imA1 = im2double(im1);
% imB1 = im2double(im2);
for p = 1:size(im1,3)
    Gim(:,:,p) = im2double(im1(:,:,p)).*(1-X) + im2double(im2(:,:,p)).*X;
end
% Gim = im2uint8(Gim1);

end