clear all;
figure(2);

x1=[-180:1:180];
x2=[-0.4:0.01:0.4];

k=1;
for we1=x1
    p=1;
    for we2=x2
        ys(p,k) = system2([we1 we2]);
        p = p+1;
    end    
    k = k+1;
end

surf(x1,x2,ys);
view([10 30]);
grid;
