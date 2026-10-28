function ShowSplited(ImgStart,DB)
subplot(2,2,1)
imshow(ImgStart(:,DB.pos1(1):DB.pos1(2),:));
subplot(2,2,2)
imshow(ImgStart(:,DB.pos2(1):DB.pos2(2),:));
subplot(2,2,3)
imshow(ImgStart(:,DB.pos3(1):DB.pos3(2),:));
subplot(2,2,4)
imshow(ImgStart(:,DB.pos4(1):DB.pos4(2),:));