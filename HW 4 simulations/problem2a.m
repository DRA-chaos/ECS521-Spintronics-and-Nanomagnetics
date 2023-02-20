
% Problem 2 a
[X,Y] = meshgrid(0:0.1:2*pi ,-pi:0.1:pi );
k=1.2*10^(-16);
Z= k*(11680 + 730320*(cos(X)).^2).*(sin(Y)).^2;
colorbar
surf(X,Y,Z)