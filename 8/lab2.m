load diabet_i.txt
we = diabet_i';
net = newc(minmax(we), 5);
w = net.IW{1}
plot3(we(1,:),we(2,:),we(3,:),'b+',w(:,1),w(:,2),w(:,3),'go'); 
hold on;
net.trainParam.epochs = 100;
    net = train(net,we);
    w = net.IW{1};
    plot3(w(:,1),w(:,2),w(:,3),'go');
w = net.IW{1}
plot3(w(:,1),w(:,2),w(:,3),'ro'); hold off
vec2ind(sim(net, [0.1; 0.1; 0.1]))