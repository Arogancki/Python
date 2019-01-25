function w=BestRBF(we, wy, procentPodzialu, er)
    % skrypt nie sprawdza poprawnosci wejsciowych parametrow
    % dziala na zasadzie happy day scenario
    % dzieli dane na uczace i testujace 
    % zwraca najkorzystniejsza wartosc spread
    
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
    spread = logspace(-2, 2, 100);
    for s=spread
        % trenowanie
        net = newrb(uczace, uczaceWyniki, er, s, 100, 1);
        % end trenowanie
        
        % test
        b = net(testujace);
        blad(index) = sum(abs(b - testujaceWyniki))/length(testujace);
        %end test
        
        index = index + 1;
    end
    %end obliczenie bledu z kazdego treningu
    
    clf % wyczyszczenie okien treningowych
    
    % rysowanie wyniku 
    hold on
    plot(spread, blad, 'b');
    grid on
    xlabel('ilosc');
    ylabel('blad');
    
    % znalezienie najmniejszego
    min = Inf;
    minI = 0;
    for b=1:1:index-1
        if (blad(b)<min)
            minI = b;
            min = blad(b);
        end
    end
    %end znalezienie
    plot(spread(minI), min, 'r*');
    hold off
    title(['Najmniejszy blad: ' num2str(minI) ' (ok. ' num2str(min) ')']);
    w=num2str(minI);
    % end rysowanie 
end