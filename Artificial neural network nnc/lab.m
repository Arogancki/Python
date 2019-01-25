load dane1.txt
we = dane1';
% ostatnim parametr to ilosc neuronow w sieci
net = newc(minmax(we), 4);  % utwórz sieæ z 4 neuronami
w = net.IW{1} % wyœwietl pocz¹tkowe wagi sieci4
plot(we(1,:),we(2,:),'b+', w(:,1),w(:,2),'go')  % wykreœl dane (+) i punkty odpowiadaj¹ce
hold on  % wagom sieci (o)
net.trainParam.epochs = 25;  % ustaw iloœæ epok uczenia
net = train(net, we);  % uczenie sieci
w = net.IW{1}  % wyœwietl wagi sieci po nauczeniu
plot(we(1,:),we(2,:),'b+', w(:,1),w(:,2),'ro')  % wykreœl dane (+) i punkty odpowiadaj¹ce
hold off  % wagom sieci (o)
vec2ind( sim(net, [0.1; 0.1]) )