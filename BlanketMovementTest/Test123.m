clc
clear all



FImg = [];
res = 127;
obj = POPSnapshots('D:\POPrint\New folder',3.76197);
total = 0;

id = 8;
% obj.JDta(1).dx = obj.JDta(1).dx+5;

D = obj.getBacthData(id);
total = total + D.Distance(1);
S = obj.getSlice(id);
imshow(S)
%%
for id = 4:4:20

D1 = obj.getBacthData(id);
step = D1.Distance(1)-total;
steppix = round(mm2pix(step,res));
S1 = obj.getSlice(id);
total = total + pix2mm(steppix,res);
S = cat(1,S1,S((size(S1,1)-steppix):end,:,:));
% S = cat(1,obj.getSlice(8),S);
end
imshow(S)
PingMe
% tic
% dmka2 = removeFisheyeRadial(dmka1,k,1);
% toc
%%
pth=Path([[2.5,3,3.5,4,4.5,5]',[-7,-5,-1,1,2,5]']); 
pth.resamplePath(200);