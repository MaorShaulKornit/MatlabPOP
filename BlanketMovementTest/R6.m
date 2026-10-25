clc
clear all

F = folderTree('D:\POPrint\ImageReady');
imID = 102;
% F = folderTree('G:\results_resChange_pop\126.95');
N = [];
for p = 2:length(F.images)
    N = cat(1,N,{F.images(p).Name});
end
ind = cellfun(@getImReradyInd,N);
[~,pos] = sort(ind);
F.images(2:end) = F.images(pos+1);

N1 = [];
for p = 1:length(F.images)
    N1 = cat(1,N1,{F.images(p).Name});
end

for p = 1:imID
    T = F.getImageByName(N1{p});
    THight1(p,1) = T.Height;
end
THight_mm1 = pix2mm(THight1,300)
%%

F = folderTree('G:\Night shift - 27.09.26\RipReady');
N = [];
for p = 2:length(F.ChildFolders)
    N = cat(1,N,{F.ChildFolders(p).images(1).Name});
end
ind = cellfun(@getImReradyInd,N);
[~,pos] = sort(ind);
F.ChildFolders(2:end) = F.ChildFolders(pos+1);
%%
N2 = [];
for p = 2:length(F.ChildFolders)
    N2 = cat(1,N2,{F.ChildFolders(p).images(1).Name});
end

for p = 1:imID
    T = F.ChildFolders(p).images(1);
    THight2(p,1) = T.Height;
end
THight_mm2 = pix2mm(THight2,400)

plot(cumsum(THight_mm1));hold on;plot(cumsum(THight_mm2));
D = THight_mm2-THight_mm1;