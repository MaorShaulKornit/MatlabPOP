clc
clear all


Dir1 = ['D:\POPrint\New folder'];
Dir2 = ['D:\POPrint\PreciseSnapshots'];

F = folderTree(Dir1);

for q = 1:length(F.images)
    Names{q} = F.images(q).Name;
end
T = struct2table( cellfun(@getPOPNameInfo,Names));
% T = T(T.CamID==1,:);
T = sortrows(T,7);
for p = 1:4:size(T,1)
    movefile([Dir1,'\',T.Input{p}],[Dir2,'\',T.Input{p}]);
    movefile([Dir1,'\',T.Input{p+1}],[Dir2,'\',T.Input{p+1}]);
    movefile([Dir1,'\',T.Input{p+2}],[Dir2,'\',T.Input{p+2}]);
    movefile([Dir1,'\',T.Input{p+3}],[Dir2,'\',T.Input{p+3}]);
    pause(3.5)
end

PingMe


%% Reset
Dir1 = ['D:\POPrint\New folder'];
Dir2 = ['D:\POPrint\PreciseSnapshots'];

F = folderTree(Dir2);
for p = 1:length(F.images)
    movefile([Dir2,'\',F.images(p).Name],[Dir1,'\',F.images(p).Name]);
end