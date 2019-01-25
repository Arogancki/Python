clear all;
x=[15:1:70];

k=1;
for x1=x
    ys(k) = system1(x1);
    k = k+1;
end

plot(x,ys);