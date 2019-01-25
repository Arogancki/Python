% dla w=!2

clear all
clc
clear

we = load('dane_sin2a_i.txt'); we = we';
wy = load('dane_sin2a_o.txt'); wy = wy';
er = 0.05;
procentPodzialu = 0.75;
BestRBF(we, wy, procentPodzialu, er);

%{
er = 0.05;
spread = 50;
net = newrb(we, wy, er, spread, 100, 1);

% dla 2 wymiaerrowych

we = load('percep_i.txt'); we = we';
wy = load('percep_o.txt'); wy = wy';
er = 0.1;
spread = 1;
net = newrb(we, wy, er, spread, 200, 1);
ilosc_neuronow = length(net.IW{1,1})
x_lin = linspace(min(we(1,:)),max(we(1,:)),50);
y_lin = linspace(min(we(2,:)),max(we(2,:)),50);
[X,Y] = meshgrid(x_lin,y_lin);
Z = griddata(we(1,:), we(2,:), wy, X, Y, 'cubic');
figure(1); mesh(X,Y,Z); axis tight; hold on;
plot3(we(1,:), we(2,:), wy,'.'); title('Powierzchnia danych');
wy2 = sim(net,we);
blad = abs(wy-wy2);
figure(2); plot(blad); title('Blad sieci');
Z1 = griddata(we(1,:), we(2,:), wy2, X, Y, 'cubic');
figure(3); mesh(X,Y,Z1); axis tight; hold on;
plot3(we(1,:), we(2,:), wy,'.'); title('Powierzchnia sieci');

%}