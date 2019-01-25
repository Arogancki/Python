
we = load('dane_2D_5_i.txt'); we = we';
wy = load('dane_2D_5_o.txt'); wy = wy';

we = [0 0 0 0 1 1 1 1; 
      0 0 1 1 0 0 1 1]; 
wy = [0 0 0 0 0 0 1 1];

net = newff(minmax(we),[5 1],{'tansig', 'logsig'}); % bez podzialu danych
%net = newff(we,wy,[5],{'tansig', 'logsig'}); % z podzialem danych
%net.outputs{2}.processFcns = {};
net.inputweights{1,1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';
net = init(net); % inicjujemy wagi losowo
net.trainParam.epochs = 100;
figure(1)
wy1 = sim(net, we);
x_lin = linspace(min(we(1,:)),max(we(1,:)),50);
y_lin = linspace(min(we(2,:)),max(we(2,:)),50);
[X,Y] = meshgrid(x_lin,y_lin);
Z = griddata(we(1,:), we(2,:), wy1, X, Y, 'cubic');
mesh(X,Y,Z)
hold on
plot3(we(1,:), we(2,:), wy,'.');
title('Powierzchnia modelu przed uczeniem')
net = train(net, we, wy);

net([1; ])