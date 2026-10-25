clc
clear all
p = 2;
im1 = imread(['Design',num2str(p),'_300dpi.tif']);
copyfile(['Underbase',num2str(p),'_127dpi.tif'],['Underbase',num2str(p),'_127dpi.png']);
[im2,~,Alpha] = imread(['Underbase',num2str(p),'_127dpi.png']);
im1 = imresize(im1,127/300);

if sum(abs((size(im1,1:2)-size(im2,1:2))))>2
    delete(['Underbase',num2str(p),'_127dpi.png']);
    error('size mismatch')
else
    im1 = imresize(im1,size(im2,1:2));
end
overlay_with_alpha(im2,im1(:,:,1:4))
delete(['Underbase',num2str(p),'_127dpi.png'])
