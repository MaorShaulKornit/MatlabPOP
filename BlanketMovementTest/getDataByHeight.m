function Dta = getDataByHeight(hgt)

h = map(hgt,2.5,5,0,1);
J = Json('appsettings.json',cd);
for N = 1:4
    tMat1 = J.Data.Transforms(N).H1.poly2roiH';
    tMat2 = J.Data.Transforms(N).H2.poly2roiH';
    k1 = J.Data.Transforms(N).H1.k;
    k2 = J.Data.Transforms(N).H2.k;
    x01 = J.Data.Transforms(N).H1.roiX0;
    x02 = J.Data.Transforms(N).H2.roiX0;
    y01 = J.Data.Transforms(N).H1.roiY0;
    y02 = J.Data.Transforms(N).H2.roiY0;
    dx1 = J.Data.Transforms(N).H1.roiDX;
    dx2 = J.Data.Transforms(N).H2.roiDX;
    dy1 = J.Data.Transforms(N).H1.roiDY;
    dy2 = J.Data.Transforms(N).H2.roiDY;
    Dta(N).tMat = tMat1.*(1-h) + tMat2.*(h);
    Dta(N).k = k1.*(1-h) + k2.*(h);
    Dta(N).x0 = x01.*(1-h) + x02.*(h);
    Dta(N).y0 = y01.*(1-h) + y02.*(h);
    Dta(N).dx = dx1.*(1-h) + dx2.*(h);
    Dta(N).dy = dy1.*(1-h) + dy2.*(h);
end

