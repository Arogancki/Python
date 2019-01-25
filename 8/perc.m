function wagi = perc(we, ilosc_klastrow, pozostale_kroki)
    % funkcja nie sprawdza poprawnosi danych
    % przyjmuje wejscia, dane nauczajace 
    % oraz maksymalna iloœæ krokow
    [n, l]=size(we);

    %inicjacja wag poczatkowych
    wagi = rand(n, ilosc_klastrow);
    wu = 0.2; %wspolczynik uczenia
    k = 1;
    while pozostale_kroki > 0
        for p = 1:l
            for n = 1:n
                % wybor neuronu do nauki
                najlepszyIndex = 0;
                najlepszyWynik = inf(1);
                for i=1:ilosc_klastrow
                    wynik = norm(we(n,p)-wagi(n, i));
                    if (najlepszyWynik > wynik)
                        najlepszyWynik = wynik;
                        najlepszyIndex = i;
                    end
                end
                % korygujemy wagi
                wagi(n, najlepszyIndex) = wagi(n, najlepszyIndex) + wu .* (we(n,p)-wagi(n, najlepszyIndex));
            end
        end

        k = k + 1;
        pozostale_kroki = pozostale_kroki - 1;
    end
    % return wagi
end