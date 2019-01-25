clear all

% stworzenie sieci
wzorce = paterns(0);
wejscie = [reshape(wzorce(:,:,1), 60, 1), reshape(wzorce(:,:,2), 60, 1), reshape(wzorce(:,:,3), 60, 1), reshape(wzorce(:,:,4), 60, 1), reshape(wzorce(:,:,5), 60, 1), reshape(wzorce(:,:,6), 60, 1), reshape(wzorce(:,:,7), 60, 1), reshape(wzorce(:,:,8), 60, 1), reshape(wzorce(:,:,9), 60, 1), reshape(wzorce(:,:,10), 60, 1)];
net = newhop(wejscie); %tworzymy sieæ i wyznaczamy jej wagi
w = net.LW{1,1}; %wagi sieci
b = net.b{1,1}; %wagi wejœæ progowych

for i = 1:3:15
    % wybor losowego wzorca
    index = mod(ceil(rand * 100), 10)+1;
    test = wzorce(:,:,index);
    a = reshape(test, 60, 1);
    
    % zaszumienie wzorca
    for j=1:i*2
        indexA = mod(ceil(rand*100), 60)+1;
        if a(indexA,1)== 1
            a(indexA,1) = -1;
        else
            a(indexA,1) = 1;
        end
    end
    
    subplot(5,3,i);
    imagesc(reshape(a(:,1), 10, 6));
    title(['zaszumiony wzorzec ', num2str(index-1) ])
    
    % test dla zaszumionego wzorca
    [y,pf,af] = sim(net, 1, {}, {a}); 
    
    wynik = reshape(y(:,end), 10, 6);
    subplot(5,3,i+1);
    imagesc(wynik); 
    
    subplot(5,3,i+2);
    imagesc(((wynik>0)*2)-1); 
end