


[X,Y] = meshgrid(0:0.1:pi ,-0:0.1:pi );
%k=1;

k= [0,0.2,0.5,0.7,1,1.4];
for i = 1:5
    Z= (11680 + 730320.*i.*(cos(X)).^2).*(sin(Y)).^2;
end

figure
plot(Y,Z)


