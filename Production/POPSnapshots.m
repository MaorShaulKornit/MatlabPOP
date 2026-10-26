classdef POPSnapshots < folderTree
    properties
        tDta
    end
    
    properties (Dependent)
       NFrames 
    end
    
    methods
        function obj = POPSnapshots(dir)
            obj = obj@folderTree(dir);
            Nms = obj.imgNames;
            obj.tDta = struct2table(cellfun(@getPOPNameInfo,Nms));
%             obj.tDta = sortrows(obj.tDta,'CamID');
%             obj.tDta = sortrows(obj.tDta,'ImgInd');          
        end
                
        function T = getBacthData(obj,id)
            T = obj.tDta(obj.tDta.ImgInd==id,:);
            T = sortrows(T,'CamID');
        end
        
        function t = get.NFrames(obj)
            t = length(unique(obj.tDta.ImgInd));
        end
        
        function A = getUInds(obj)
            A = unique(obj.tDta.ImgInd);
        end
        
        function Row = getRow(obj,ImgInd)
            Row = POPRow(obj,ImgInd);
        end
    end
end

