function DB = AddLimits(ImgStart,DB)

[~,BB] = imcrop(ImgStart);

Sz = BB(3)/(DB.NInARow);
DB.pos1 = [BB(1),BB(1)+Sz];
DB.pos2 = [BB(1)+Sz,BB(1)+2*Sz];
DB.pos3 = [BB(1)+2*Sz,BB(1)+3*Sz];
DB.pos4 = [BB(1)+3*Sz,BB(1)+4*Sz];