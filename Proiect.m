clc
clear
close all

%% incarcare imagine
imagIncarcata = im2double(imread('tema17.png'));
% imagIncarcata = im2double(imread('images.png'));
% imagIncarcata = im2double(imread('download1.png'));
% imagIncarcata = im2double(imread('download1.jfif'));
% imagIncarcata = im2double(imread('download2.jfif'));
% imagIncarcata = im2double(imread('download3.jfif'));

imagIncarcata = 0.299 *imagIncarcata(:,:,1) + 0.587*imagIncarcata(:,:,2) + 0.114*imagIncarcata(:,:,3);
figure(1)
imshow(imagIncarcata)
title("imagine incarcata")
%% dimensiuni imagine
[Lini,Coloane] = size(imagIncarcata);

%% accentruare contrast imagine incarcata daca e nevoie
% imagAccentuata = accentuare_contrast(imagIncarcata);
% figure()
% imshow(imagAccentuata)
% title("imagine accentuata")

%% segmentarea imaginii
imagSegmentata = segmentare(imagIncarcata);

figure()
imshow(imagSegmentata)
title("imagine segmentata")
%% aflare margine tabla
% varianta in care se poate determina marginea si fara a segmenta imaginea inainte
margine_tabla = 0;
if imagSegmentata(1,1)<=0.5 %% margine neagra
    D = diag(imagSegmentata(1:Lini,1:Coloane));
    for i = 1: length(D)-1
        if D(i) <=0.5
            margine_tabla = margine_tabla+1;
        else
            break
        end
    end
else %% margine alba
    D = diag(flipud(imagSegmentata(1:Lini,1:Coloane)));
    for i = 1: length(D)-1
        if D(i)>=0.5
            margine_tabla = margine_tabla+1;
        else
            break
        end
    end
end

margine_tabla = margine_tabla+1;

%% aflare numar si coloane un chenar
LiniiUnPatrat = ceil((Lini-margine_tabla*2)/8);
ColoaneUnPatrat = ceil((Coloane-margine_tabla*2)/8);

%% valori initiale pentru variabie
contor_piese_negre = 0;
contor_piese_albe  = 0;
contor_chenare_negre_libere = 0;
contor_chenare_albe_libere = 0;

k = 0; % numarul chenarului

%% for-uri pentru parcurgerea tablei de sah din chenar in chenar
for L = margine_tabla+1:LiniiUnPatrat:Lini-margine_tabla
    for C = margine_tabla+1:ColoaneUnPatrat:Coloane-margine_tabla
        % algoritmul se opreste dupa ce chenarul selectat este parcurs
        if k==64
            return;
        end
        k = k+1;
        
        culoare_chenar = mod(k,2); % 1-alb, 0-negru ; impar alb, par negru
        
        %% atribuirea de date pentru chenar
        chenar =  (imagSegmentata(L:LiniiUnPatrat+L,C:ColoaneUnPatrat+C));
        
        [lc,cc] = size (chenar); % verificare daca corespunde cu numarul de linii si coloane
        
        lm = ceil(LiniiUnPatrat/2); % linia de mijoc a chenarului
        cm = ceil(ColoaneUnPatrat/2);% coloana de mijoc a chenarului
        %% matricea pentru care se calculeaza numarul de pixeli
        
        mijlocChenar = chenar(lm-10 : lm+10, cm-10 : cm+10);
        
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
        
        %% afisare pe rand a chenarelor
        figure(6)
        imshowpair(chenar,mijlocChenar,'montage')
        title("chenar")
%         pause(0.5)
        
    end
    
end
%% afisare in command window a informatiilor de interes
fprintf('chenarul contine %d piese albe\n',contor_piese_albe);
fprintf('chenarul contine %d piese negre\n',contor_piese_negre);
fprintf('chenarul contine %d chenare albe libere\n',contor_chenare_albe_libere);
fprintf('chenarul contine %d chenare negre libere\n',contor_chenare_negre_libere);
