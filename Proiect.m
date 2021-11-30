clc
clear
close all

%% incarcare imagine
% imagIncarcata = rgb2gray(im2double(imread('tema17.png')));
imagIncarcata = rgb2gray(im2double(imread('images.jfif')));
% imagIncarcata = rgb2gray(im2double(imread('download1.png')));

figure(1)
imshow(imagIncarcata)

%% aplicare filtru uniform pe imaginea incarcata
% imagFiltrata = filtrare_zgomot_uniform(imagIncarcata);
% figure()
% title("")
% imshow(imagFiltrata)
%% dimensiuni imagine
[Lini,Coloane] = size (imagIncarcata);

%% segmentarea imaginii
imagSegmentata = segmentare(imagIncarcata);
figure()
imshow(imagSegmentata)

%% aflare margine tabla
margine_tabla_L = length(find(imagSegmentata(Lini-10,1:10) == 1 ));
margine_tabla_C = length(find(imagSegmentata(Lini-10:Lini,10) == 1 ));

%% aflare numar si coloane un chenar
LiniiUnPatrat = ceil((Lini-margine_tabla_L*2)/8);
ColoaneUnPatrat = ceil((Coloane-margine_tabla_C*2)/8);

%% valori initiale pentru variabie
chenar = zeros(Lini,Coloane);
culoare_chenar = 1; % 1-alb, 0-negru ; impar alb, par negru

% L = margine_tabla_L ;
% C = margine_tabla_C;

contor_piese_negre = 0;
contor_piese_albe  = 0;
contor_chenare_negre_libere = 0;
contor_chenare_albe_libere = 0;

k = 0; % numarul chenarului

%% primele for-uri sunt pentru parcurgerea tablei de sah din chenar in chenar
for L = margine_tabla_L:LiniiUnPatrat:Lini-LiniiUnPatrat
    for C = margine_tabla_C:ColoaneUnPatrat:Coloane-ColoaneUnPatrat
        % algoritmul se opreste dupa ce chenarul selectat este parcurs
        if k==64
            return;
        end
        k = k+1;
        % atribuirea de date pentru chenar
        for l = L+1:LiniiUnPatrat+L-1
            for c = C+1:ColoaneUnPatrat+C-1
                chenar(l,c) = imagSegmentata(l,c);
            end
        end
        
        lm = ceil(LiniiUnPatrat/2);
        cm = ceil(ColoaneUnPatrat/2);
        
        %% varianta cea mai buna
        mijlocChenar = chenar(l-lm-10 : l-lm+10, c-cm-10 : c-cm+10);
        %% alte variante incercate
%         mijlocChenar = chenar(l-LiniiUnPatrat+2:l-4,c-ceil(ColoaneUnPatrat/2)-1:c-ceil(ColoaneUnPatrat/2)+1);

%         mijlocChenar = chenar(l-ceil(LiniiUnPatrat/4)-floor(LiniiUnPatrat/4):l-ceil(LiniiUnPatrat/4)+floor(LiniiUnPatrat/4),...
%             c-ceil(ColoaneUnPatrat/4)-floor(ColoaneUnPatrat/4):c-ceil(ColoaneUnPatrat/4)+floor(ColoaneUnPatrat/4));

%         mijlocChenar = chenar(l-LiniiUnPatrat+lm-2:l-lm-2,c-ColoaneUnPatrat+cm-2:c-cm-2);

%         mijlocChenar = chenar(l-LiniiUnPatrat+2:l-2,c-ColoaneUnPatrat+2:c-2);
%         
%         x = diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c));
%         y = diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c),-1);
%         yy = diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c),-2);
%         yyy = diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c),-3);
%         w = diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c),1);
%         ww = diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c),2);
%         www= diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c),3);
%         mijlocChenar = [x; y;yy;yyy; w;ww;www];
%         
        %% aflarea numarului de pixeli din partea de chenar pe care se face analiza
        pixeliAlbi = numel(find(mijlocChenar == 1));
        pixeliNegrii = numel(find(mijlocChenar == 0));
        
        %% decizi asupra numarului de piese
        
        if (pixeliAlbi >= 0.9*numel(mijlocChenar))
            tip_chenar = "alb gol";
            contor_chenare_albe_libere = contor_chenare_albe_libere+1;
            fprintf('chenarul %d este %s.\n',k,tip_chenar);
            disp("________________________________")
            continue
        end
        
        if (pixeliNegrii >= 0.9*numel(mijlocChenar))
            tip_chenar = "negru gol";
            contor_chenare_negre_libere = contor_chenare_negre_libere+1;
            fprintf('chenarul %d este %s.\n',k,tip_chenar);
            disp("________________________________")
            continue
        end
        
        if (pixeliAlbi ~= pixeliNegrii)
            tip_chenar = "cu piesa";
            if (pixeliAlbi> pixeliNegrii)
                piesa = "alba";
                contor_piese_albe = contor_piese_albe+1;
                fprintf('chenarul %d contine o piesa %s.\n',k,piesa);
                disp("________________________________")
            else
                piesa = "neagra";
                contor_piese_negre = contor_piese_negre+1;
                fprintf('chenarul %d contine o piesa %s.\n',k,piesa);
                disp("________________________________")
            end
        end
        % afisare pe rand a pieselor
        figure(6)
        imshow(chenar)
        pause(0.5)
        
    end
    
end

% afisare finala a chenarului, utila in cazul in care ultimul chenar este gol
% caz in care se trece la urmatoarea iteratie
figure(6)
imshow(chenar)