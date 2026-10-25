function DB = AddHight(DB,h)

rtio = map(h,DB.H1.Height,DB.H2.Height,0,1);
DB.Hn.Height = h;

for p = 1:4
    DB.Hn.(['im',num2str(p)]).dX = (1-rtio).*DB.H1.(['im',num2str(p)]).dX + rtio.*DB.H2.(['im',num2str(p)]).dX;
    DB.Hn.(['im',num2str(p)]).dY = (1-rtio).*DB.H1.(['im',num2str(p)]).dY + rtio.*DB.H2.(['im',num2str(p)]).dY;
end

flds = fields(DB.H1.Margins);
for q = 1:size(flds,1)
    DB.Hn.Margins.(flds{q}) = (1-rtio).*DB.H1.Margins.(flds{q}) + rtio .* DB.H2.Margins.(flds{q});
end
    