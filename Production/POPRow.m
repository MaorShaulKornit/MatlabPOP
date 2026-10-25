classdef POPRow < handle
    properties
        Dta
        ImgInd
        Props
    end
    
    methods
        function obj = POPRow(F,ind)
            tf = F.tDta.ImgInd == ind;
            obj.Dta = F.tDta(tf,:);
            obj.ImgInd = ind;
            obj.Props = F.images(tf);
        end
        
        function d = getDist(obj)
             d = obj.Dta.Distance(1);
        end
    end
end

