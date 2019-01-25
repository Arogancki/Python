function R = ident_exp(Nl,Nr)
% R = IDENT_EXP(NL,NR) Identyfikacja eksperymentalna.
%    Dla slownika NL-wyrazowego (np. 3,5,7), przeprowadz NR rund
%    identyfikacji eksperymentalnej (wartosc domyslna 10 rund). Na jedna
%    runde przypada 19 pytan. Program wykresla wyniki identyfikacji oraz
%    zwraca macierz R o wymiarach NLx19 ze zidentyfikowanymi funkcjami
%    przynaleznosci dla poszczegolnych kwantyfikatorow.
%    Uzytkownik odpowiada na pytanie wprowadzajac numer kwantyfikatora
%    ktory najlepiej opisuje przedstawiona sytuacje na planszy.
%

% v0.1 <GNU GPL> 2008 M.Suchorzewski, ZSI.WI.PS
%

if (nargin==1) Nr = 10; end
if (Nr<1) error('Liczba rund musi byc wieksza od zero'); end
if (Nr>20) warning('Wybrales duza liczbe rund, czeka Cie sporo pytan'); end
if (Nl<1) error('Rozmiar slownika musi byc wiekszy od zera'); end


%% Possible lingustic domains:
XL{3} = {'Male', 'Srednie', 'Duze'};
XL{5} = {'Bardzo Male', 'Male', 'Srednie', 'Duze', 'Bardzo Duze'};
XL{7} = {'Prawie zero', 'Bardzo Male', 'Male', 'Srednie', 'Duze', 'Bardzo Duze', 'Prawie jeden'};

%% Check if there is requested linguistic domain:
if (Nl>length(XL) | isempty(XL{Nl}))
	s = '';
	for i=1:length(XL)
		if (~isempty(XL{i}))
			s = strcat(s, num2str(i), ',');
		end
	end
	error(strcat('Rozmiar slownika nieprawidlowy, dostepne sa slowniki o rozmiarach: ', s));
end

disp('*** Identyfikacja eksperymentalna v0.1 ***');
disp(sprintf('    Czeka Cie %i pytan. Wprowadz ''q'' by przerwac.',19*Nr));

%% Prepare figure
Bh = prepare_figure(XL{Nl});

%% 19 states of the board:
S = [1:19]*5;
Ne = 19*Nr;

%% 190 experiments. Each state must be presented 10 times. Randomize the order:
E = mod(randperm(Ne)',19)+1;

%% Vector for answers
A = zeros(Ne,1);
%% Result matrix
R = zeros(Nl,19);
%% Premature quit
Q = 0;
%% Proceed:
for i=1:length(E)
	%% Generate the board corresponding to state E(i):
	B = reshape(randperm(100),10,10);
	B = (B>S(E(i)));

	plot_board(B,Bh);
	a = input(sprintf('%i. Wybierz kwantyfikator: ',i),'s');
	%% Verify the answer:
	while (isempty(regexp(a,strcat('[1-',num2str(Nl),']'))))
		if (~isempty(regexp(a,'^[qQ]$')))
			disp('Eksperyment zakonczony przedwczesnie.');
			Q = i;
			break;
		end
		a = input(strcat('Podaj liczbe z zakresu [1-', num2str(Nl), '] lub ''q'' aby zakonczyc: '),'s');
	end
	if (Q) break; end
	A(i) = str2num(a);
end

%% Prepare resulting table:
for i=1:Nl
	for j=1:length(S)
		R(i,j) = sum(all([E==j A==i],2));
	end
end
R = R/Nr;

%% Plot results:
clf
set(gcf,'color',[0.9 0.9 0.9]);
plot(S/100,R','.-');
ylim([0 1.2]);
title('Wyniki identyfikacji eksperymentalnej');
xlabel('Rzeczywiste prawdopodobienstwo, p');
ylabel('Prawdopodobienstwo klasyfikacji');
legend(XL{Nl},'location','northeastoutside');



function Bh = prepare_figure(XL)
	clf;
	figure(1);
	set(gcf,'color',[0.5 0.5 0.5]);
	colormap([0.2 0.2 0.2; 0.8 0.8 0.8]);
	Bh = axes('position',[0.05 0.1 0.5 0.8]);
	%% Prepare the question:
	S1= {'Jakie jest prawdopodobienstwo', 'wylosowania CIEMNEGO pudelka?'};
	for l=1:length(XL)
		s = strcat({num2str(l)},{'. '},{XL{l}});
		S2{l} = s{1};
	end
	annotation('textbox','position',[0.6 0.6 0.3 0.2],'verticalalignment','middle',...
		'FitHeightToText','on','backgroundcolor',[0.6 0.6 0.6],'string',S1);
	annotation('textbox','position',[0.6 0.2 0.3 0.4],'verticalalignment','middle',...
		'FitHeightToText','on','margin',16,'fontsize',14,'fontweight','bold',...
		'backgroundcolor',[0.6 0.6 0.6],'string',S2);


function plot_board(B,Bh)
	cla(Bh);
	imagesc(B,'parent',Bh);
	%% Draw grid
	for i=1.5:10.5
		line([0 10.5],[i i],'color',[0.5 0.5 0.5]);
		line([i i],[0 10.5],'color',[0.5 0.5 0.5]);
	end
	


