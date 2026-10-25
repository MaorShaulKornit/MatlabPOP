function showSeperationLines(DB,offset)
if nargin < 2
    offset = 15;
end
hold on
x = DB.Hn.Margins.pos12+1;
plot([x-offset,x-offset],[0,1100],'r')
plot([x+offset,x+offset],[0,1100],'r')
x = x + DB.Hn.Margins.pos23-DB.Hn.Margins.pos21+1;
plot([x-offset,x-offset],[0,1100],'r')
plot([x+offset,x+offset],[0,1100],'r')
x = x + DB.Hn.Margins.pos34-DB.Hn.Margins.pos32+1;
plot([x-offset,x-offset],[0,1100],'r')
plot([x+offset,x+offset],[0,1100],'r')
hold off