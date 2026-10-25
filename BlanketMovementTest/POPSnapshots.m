classdef POPSnapshots < folderTree
    properties
        tDta
        JDta
    end
    
    methods
        function obj = POPSnapshots(dir,h)
            obj = obj@folderTree(dir);
            Nms = obj.imgNames;
            obj.tDta = struct2table(cellfun(@getPOPNameInfo,Nms));
            obj.tDta = sortrows(obj.tDta,'CamID');
            obj.tDta = sortrows(obj.tDta,'ImgInd');          
            obj.JDta = getDataByHeight(h);
        end
        
        function [c1,c2,c3,c4] = getBatchByInd(obj,id)
           T = obj.getBacthData(id);
           cp1 = obj.getImageByName(T.Input(1));
           c1 = cp1.getImage;
           cp2 = obj.getImageByName(T.Input(2));
           c2 = cp2.getImage;
           cp3 = obj.getImageByName(T.Input(3));
           c3 = cp3.getImage;
           cp4 = obj.getImageByName(T.Input(4));
           c4 = cp4.getImage;
        end
        
        function T = getBacthData(obj,id)
            T = obj.tDta(obj.tDta.ImgInd==id,:);
            T = sortrows(T,'CamID');
        end
        
        
        function Img = getCalibratedFrame(obj,c,N)
            k = obj.JDta(N).k;
            dmka2 = myRealFishEye(c,k);
            tMat = obj.JDta(N).tMat;
            tform = projective2d(tMat);
            [dmka3,rb] = imwarp(dmka2,tform,'FillValues',0);
            x0 = obj.JDta(N).x0;
            y0 = obj.JDta(N).y0;
            dx = obj.JDta(N).dx;
            dy = obj.JDta(N).dy;
            y0 = round(y0-rb.YWorldLimits(1));
            x0 = round(x0-rb.XWorldLimits(1));
            Img = dmka3(y0:y0+dy-1,x0:x0+dx-1,:);
        end
        
        function S = getSlice(obj,id)
            [c1,c2,c3,c4] = obj.getBatchByInd(id);
            S = obj.getCalibratedFrame(c1,1);
            S = cat(2,S,obj.getCalibratedFrame(c2,2));
            S = cat(2,S,obj.getCalibratedFrame(c3,3));
            S = cat(2,S,obj.getCalibratedFrame(c4,4));
        end
    end
end

