function plotFunc(F,rngX,rngY,varargin)

if nargin < 2
    rngX = [-10,10];
end

X = linspace(rngX(1),rngX(2),300);
Y = F(X);
if nargin < 3
    rngY = [min(Y),max(Y)];
end

plot(X,Y,varargin{:})
axis([rngX,rngY])