clc
clear all

F1 = folderTree('D:\POPrint\PreciseSnapshots');
N = [];
for p = 1:length(F1.images)
    N = cat(1,N,{F1.images(p).Name});
end

T1 = struct2table(cellfun(@getPOPNameInfo,N));
T1 = T1(T1.CamID==1,:);
T1 = sortrows(T1,4);
% T1 = T1(3:end,:);
THight1_mm =  T1.Distance;
%%
F2 = folderTree('D:\POPrint\ImageReady');
N = [];
for p = 2:length(F2.images)
    N = cat(1,N,{F2.images(p).Name});
end
ind = cellfun(@getImReradyInd,N);
[~,pos] = sort(ind);
N = N(pos);
for p = 1:size(N,1)
    T = F2.getImageByName(N{p});
    THight(p,1) = T.Height;
end
THight_mm = pix2mm(THight,300);

THight2_mm = cumsum(THight_mm);
%%
% plot(THight1_mm(1:end-1))
% hold on
% plot(THight2_mm)
THight1_mm = THight1_mm-THight1_mm(1);
THight2_mm = THight2_mm-THight2_mm(1);
X = [THight1_mm,THight2_mm,THight2_mm - THight1_mm];
% X = X-mean(X);
