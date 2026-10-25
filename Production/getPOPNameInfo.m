function info = getPOPNameInfo(Name)
% xclear Name
% 'Name = Production_168_3_4_4107p11.bmp';
t1 = strsplit(Name,'_');
t2 = strsplit(t1{end},'.');
d = strsplit(t2{1},'p');
d1 = str2double(strjoin(d,'.'));
info.Input = Name;
info.FileType = t2{end};
info.ImgName = t1{1};
info.ImgInd = str2double(t1{2});
info.CamID = str2double(t1{3});
info.TotCam = str2double(t1{4});
info.Distance = d1;
