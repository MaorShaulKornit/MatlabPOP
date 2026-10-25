clc
clear all

dir = ['D:\POPrint\ImageReady'];
F = folderTree(dir);
for p = 1:length(F.images)
    IRNm{p} = F.images(p).Name;
end
Ind = cellfun(@getImReradyInd,IRNm(2:end));
[~,dx] = sort(Ind);
F.images(2:end) = F.images(dx+1);
%%
for p = 1:length(F.images)
    H(p) = F.images(p).Height;
end

%%
H1 = cumsum(H);

%%
D1 = pix2mm(H1,300);
%%

F2 = folderTree('D:\POPrint\New folder');
for q = 1:length(F2.images)
    Names{q} = F2.images(q).Name;
end
T = struct2table( cellfun(@getPOPNameInfo,Names));
T = T(T.CamID==1,:);
T = sortrows(T,7);
D2 = T.Distance;

%%
mnfls = min(size(D1,2),size(D2,1));
D3 = D1(3:mnfls)'-D2(3:mnfls);

%%
plot(D3 - D3(1))

