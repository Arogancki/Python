%dane wejciowe

we = [0 0 0 0 1 1 1 1; 
      0 0 1 1 0 0 1 1; 
      0 1 0 1 0 1 0 1];

wy = [0 0 0 1 0 1 1 0];

we = load('dane_1D_sin1a_i.txt'); we = we';
wy = load('dane_1D_sin1a_o.txt'); wy = wy';
epochs = 100;
procentPodzialu = 0.75;
MaxHiddenLayers = 100;
rodzaje = {'logsig', 'purelin'}; 
%FindBestLayersAmount(we, wy, procentPodzialu, epochs, MaxHiddenLayers, rodzaje)

%function b = FindBestLayersAmount(we, wy, procentPodzialu, epochs, MaxHiddenLayers, rodzaje)
    % funkcja nie sprawdza prawidlowscci wejscia
    % dziala na zasadach happy day scenerio
    
    % podzial wektora na uczace i testujace
    [w, c] = size(we);
    uczace = [];
    uczaceWyniki = [];
    uczaceI = 1;
    testujace = [];
    testujaceWyniki = [];
    testujaceI = 1;
    for p=1:c
        % aktualna probka trafi do testu czy do uczenia
        czyDoTestujacych = rand > procentPodzialu;
        % jest ostatnia iteracja i nie ma danych testujacych 
        % doloz do testujacych
        if (p==c) && isempty(testujace)
            doTestujacych = 1;
        end
        if czyDoTestujacych
            testujace(:,testujaceI) = we(:,p);
            testujaceWyniki(:,testujaceI) = wy(:,p);
            testujaceI = testujaceI + 1;
        else
            uczace(:,uczaceI) = we(:,p);
            uczaceWyniki(:,uczaceI) = wy(:,p);
            uczaceI = uczaceI + 1;
        end
    end
    % end podzial
    
    % obliczenie bledu z kazdego treningu
    index = 1;
    blad = [];
    for i=1:1:MaxHiddenLayers
        % trenowanie
        net = newff(minmax(uczace),[i 1],rodzaje);
        net.inputweights{1,1}.initFcn = 'rands';
        net.biases{1}.initFcn = 'rands';
        net = init(net);
        net.trainParam.epochs = epochs;
        net = train(net, uczace, uczaceWyniki);
        % end trenowanie
        
        % test
        b = net(testujace);
        blad(index) = sum(abs(b - testujaceWyniki))/length(testujace);
        %end test
        
        index = index + 1;
    end
    % end obiczenie
    
    % rysowanie wyniku 
    hold on
    plot(1:1:MaxHiddenLayers, blad, 'b');
    grid on
    xlabel('ilosc warstw ukrytych');
    ylabel('blad');
    
    % znalezienie najmniejszego
    min = Inf;
    minI = 0;
    for b=1:1:MaxHiddenLayers
        if (blad(b)<min)
            minI = b;
            min = blad(b);
        end
    end
    %end znalezienie
    plot(minI, min, 'r*');
    hold off
    title(['Najmniejszy blad: ' num2str(minI) ' (ok. ' num2str(min) ')'])
    % end rysowanie 
    
%end