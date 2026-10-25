clc
clear all

F = folderTree('G:\KornitProjects\PreciseStuff\Night shift - 27.09.26\RipReady - Copy');
for p = 1:length(F.ChildFolders)
    F1 = F.ChildFolders(p);
    for q = 1:length(F1.images)
        if strcmp(F1.images(q).type,'tif')
            F1.images(q).compressOneBit;
        end
    end
    disp([num2str(p),'\',num2str(length(F.ChildFolders))]);
end
PingMe