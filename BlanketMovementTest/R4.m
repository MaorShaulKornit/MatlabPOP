clc
clear all



F1 = folderTree('D:\POPrint\PreciseSnapshots');
N = [];
for p = 1:length(F1.images)
    N = cat(1,N,{F1.images(p).Name});
end

T1 = struct2table(cellfun(@getPOPNameInfo,N));
T1 = T1(T1.CamID==2,:);
T1 = sortrows(T1,4);
Distance = 0;
Res = 127;
resIn = 300;
% zoomFctr = 1;
err = 0;
CStep = 485;
StpA = [];
for p = 1:25
    if p==1
        Q = F1.getImageByName(T1.Input(p));
        Img = Utills.getwarpedFull(Q.getImage,2);
%         Img = imgZoom(Img,zoomFctr);
        Img = Img(746:746+CStep-1,:,:);
        Total = mm2pix(T1.Distance(p),Res);
    else
        
        Step = T1.Distance(p)-pix2mm(Total,Res);
        StepPix = mm2pix_rounded(Step,Res);
        StpA = cat(1,StpA,StepPix);
        Q = F1.getImageByName(T1.Input(p));
        Img2 = Utills.getwarpedFull(Q.getImage,2);
%         Img2 = imgZoom(Img2,zoomFctr);

%         cntr = round(size(Img2,1)/2);
%         Img = [Img2(1:cntr+StepPix-1,:,:);Img(cntr:end,:,:)];
        Img = cat(1,Img2(746:746+StepPix-1,:,:),Img);
        Total = Total + StepPix;
    end
end


F2 = folderTree('D:\POPrint\ImageReady');
imID = 28;
% F = folderTree('G:\results_resChange_pop\126.95');
N = [];
for p = 2:length(F2.images)
    N = cat(1,N,{F2.images(p).Name});
end
Img2= [];
ind = cellfun(@getImReradyInd,N);
[~,pos] = sort(ind);
N = N(pos);
fctor = Res/resIn;
xtra = [0,0];
for p = 2:imID
    T = F2.getImageByName(N{p});
    X = T.getImage;
    Sz = size(X,1:2).*fctor + xtra;
    xtra = Sz - round(Sz);
    X = imresize(X,round(Sz));
    Img2 = cat(1,X(:,1328:1328+size(Img,2)-1,:),Img2);
end
PingMe

strt = size(Img2,1)-size(Img,1);
Img3 = circshift(Img2,96);
Img3 = Img3(strt:end-1,:,:);
%%
imshow2(Img3(:,:,1:3),Img);
%%

overlay_with_alpha(Img,Img3(:,:,1:4))






