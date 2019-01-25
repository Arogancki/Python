v = [30 60 80 100 120]; % predkosci samochodu
n = [78.9 88.9 98.9]; % wspolczyniki wagi 
t = [10 30 50 70 100]; % odelglosci od przeszkody 

we=0;
wy=0;

wyi = 1;
for vv = v
    for nv = n
        for tv = t
            we(1, wyi) = vv;
            we(2, wyi) = nv;
            we(3, wyi) = tv;
            wy(wyi) = ((vv * vv) / (nv * 2)) < tv; % wektor wag
            wyi = wyi + 1;
        end
    end
end