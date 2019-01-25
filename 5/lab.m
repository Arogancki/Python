% and
we = [0 0 1 1; 0 1 0 1];
wy = [0 0 0 1];
% or 
we = [0 0 0 0 1 1 1 1;
      0 0 1 1 0 0 1 1
      0 1 0 1 0 1 0 1];
wy = [0 1 1 1];
% xor
we = [0 0 1 1; 0 1 0 1];
wy = [0 1 1 0];

% we = load('dane3d_3_i.txt')';
% wy = load('dane3d_3_o.txt')';

v = 20:10:140; % predkosci samochodu
n = [78.9 88.9 98.9]; % wspolczyniki nacisku opon
t = 10:10:100; % odelglosci od przeszkody 

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

% net = newp([0 1; 0 1], 1); %lub 
net = newp(minmax(we), 1);
y = sim(net, we);% symulacja dzia³ania sieci
figure(1); plot(abs(y-wy)); %wykres b³êdu
title('Error before learning');
net = init(net); % ponowne losowanie wag pocz¹tkowych
net.trainParam.epochs = 500; %maksymalna iloœæ epok uczenia
net = train(net, we, wy); %uczenie sieci
y = sim(net, we); %symulacja dzia³ania sieci
figure(2); plot(abs(y-wy)); %wykres b³êdu sieci
title('Error after learning');
net.iw{1,1} %wagi na wejœciach neuronu
net.b{1} %waga na wejœciu progowym
figure(3); plotpv(we, wy); %wykres danych
plotpc(net.iw{1,1}, net.b{1}); %linia podzia³u danych