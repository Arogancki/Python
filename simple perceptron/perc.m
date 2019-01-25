function wagi = perc(we, wy, pozostale_kroki)
    % funkcja nie sprawdza poprawnosi danych
    % przyjmuje wejscia, dane nauczajace 
    % oraz maksymalna iloœæ krokow
    [n, l]=size(we);

    %inicjacja wag poczatkowych
    wagi = rand(1, n+1); % +1 bo w0
    we = [ones(1,l); we]; % dodanie sztucznej 1 na w0

    wu = 0.15; %wspolczynik uczenia
    zle=1;
    k = 1;
    while pozostale_kroki > 0 && zle > 0
        zle = 0;
        for p = 1:l
            % obliczenie wyjscia Yp dla neuronu
            Yp = 0;
            for y=1:n+1
                Yp = Yp + (we(y, p) * wagi(k, y));
            end

            % obliczamy blad
            Qp = wy(p) - double(Yp>0);

            % korygujemy wagi
            if Qp ~= 0
                wagiKorekta = wagi(k,:) + (wu * Qp .* we(:,p)');
                wagi = [wagi; wagiKorekta];
                zle = zle + 1;
            end

        end

        k = k + 1;
        pozostale_kroki = pozostale_kroki - 1;
    end
    wagi = wagi(end-1,:);
    % return wagi
end