clc
clear
close all

%% incarcare imagine
% imagIncarcata = rgb2gray(im2double(imread('tema17.png')));
% imagIncarcata = rgb2gray(im2double(imread('images.png')));
% imagIncarcata = rgb2gray(im2double(imread('download1.png')));
imagIncarcata = rgb2gray(im2double(imread('download1.jfif')));
% imagIncarcata = rgb2gray(im2double(imread('download2.jfif')));
% imagIncarcata = rgb2gray(im2double(imread('download3.jfif')));
figure(1)
imshow(imagIncarcata)
title("imagine incarcata")
%% aplicare filtru uniform pe imaginea incarcata
imagFiltrata = filtrare_zgomot_uniform(imagIncarcata);
figure()
imshow(imagFiltrata)
title("imagine filtrata")
%% dimensiuni imagine
[Lini,Coloane] = size (imagIncarcata);

%% segmentarea imaginii
imagSegmentata = segmentare(imagFiltrata);
figure()
imshow(imagSegmentata)
title("imagine segmentata")
%% aflare margine tabla

% varianta 3
margine_tabla = 0;
if imagSegmentata(1,1)==0
    D = diag(imagSegmentata(1:Lini,1:Coloane));
    for i = 1: length(D)-1
        if D(i)==D(i+1)
            margine_tabla = margine_tabla+1;
        else
            break
        end
    end
else
     D = diag(flipud(imagSegmentata(1:Lini,1:Coloane)));
    for i = 1: length(D)-1
        if D(i)==D(i+1)
            margine_tabla = margine_tabla+1;
        else
            break
        end
    end
end
        
 margine_tabla = margine_tabla+1;


% varianta 2
% margine_tabla_C = 0;
% margine_tabla_L = 0;
% 
% for i = 1: Coloane-1
%     if imagSegmentata(10,i)==imagSegmentata(10,i+1)
%         margine_tabla_C = margine_tabla_C+1;
%     else
%         break
%     end
% end
% 
% for i = 1: Lini-1
%     if imagSegmentata(i,10)==imagSegmentata(i+1,10)
%         margine_tabla_L = margine_tabla_L+1;
%     else
%         break
%     end
% end
% varianta 1
% margine_tabla_L = length(find(imagSegmentata(Lini-10,1:10) == 1 ));
% margine_tabla_C = length(find(imagSegmentata(Lini-10:Lini,10) == 1 ));

%% aflare numar si coloane un chenar
LiniiUnPatrat = ceil((Lini-margine_tabla*2)/8);
ColoaneUnPatrat = ceil((Coloane-margine_tabla*2)/8);

%% valori initiale pentru variabie
chenar = zeros(Lini,Coloane);


% L = margine_tabla_L ;
% C = margine_tabla_C;

contor_piese_negre = 0;
contor_piese_albe  = 0;
contor_chenare_negre_libere = 0;
contor_chenare_albe_libere = 0;

k = 0; % numarul chenarului

%% primele for-uri sunt pentru parcurgerea tablei de sah din chenar in chenar
for L = margine_tabla+1:LiniiUnPatrat:Lini-margine_tabla
    for C = margine_tabla+1:ColoaneUnPatrat:Coloane-margine_tabla
        % algoritmul se opreste dupa ce chenarul selectat este parcurs
        if k==64
            return;
        end
        k = k+1;
        culoare_chenar = mod(k,2); % 1-alb, 0-negru ; impar alb, par negru
       
        %% atribuirea de date pentru chenar
%         for l = L:LiniiUnPatrat+L
%             for c = C:ColoaneUnPatrat+C
%                 chenar(l,c) = imagSegmentata(l,c);
%             end
%         end
        chenar =  imagSegmentata(L:LiniiUnPatrat+L,C:ColoaneUnPatrat+C);
        
        [ls,cs] = size (chenar); % verificare daca corespunde cu numarul de linii si coloane
        %         atribuirea de date pentru chenar
        %         for l = L:LiniiUnPatrat+L
        %             for c = C:ColoaneUnPatrat+C
        %                 chenar(l,c) = imagSegmentata(l,c);
        %             end
        %         end
        %         figure(6)
        %         title("chenar")
        %         imshow(chenar)
        %         pause(1)
        %
        %
        lm = ceil(LiniiUnPatrat/2);
        cm = ceil(ColoaneUnPatrat/2);
        %
        %% varianta cea mai buna
%         mijlocChenar = chenar(lm-10 : lm+10, cm-10 : cm+10);
% mijlocChenar = chenar;
        %         %% alte variante incercate
        % %         mijlocChenar = chenar(l-LiniiUnPatrat+2:l-4,c-ceil(ColoaneUnPatrat/2)-1:c-ceil(ColoaneUnPatrat/2)+1);
        %
%                 mijlocChenar = chenar(lm-ceil(LiniiUnPatrat/4)-floor(LiniiUnPatrat/4):lm-ceil(LiniiUnPatrat/4)+floor(LiniiUnPatrat/4),...
%                     cm-ceil(ColoaneUnPatrat/4)-floor(ColoaneUnPatrat/4):cm-ceil(ColoaneUnPatrat/4)+floor(ColoaneUnPatrat/4));
        %
        % %         mijlocChenar = chenar(l-LiniiUnPatrat+lm-2:l-lm-2,c-ColoaneUnPatrat+cm-2:c-cm-2);
        %
        % %         mijlocChenar = chenar(l-LiniiUnPatrat+2:l-2,c-ColoaneUnPatrat+2:c-2);
        % %
        % %         x = diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c));
        % %         y = diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c),-1);
        % %         yy = diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c),-2);
        % %         yyy = diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c),-3);
        % %         w = diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c),1);
        % %         ww = diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c),2);
        % %         www= diag(chenar(l-LiniiUnPatrat:l,c-ColoaneUnPatrat:c),3);
        % %         mijlocChenar = [x; y;yy;yyy; w;ww;www];
        % %
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
            %% varianta fara switch
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
            
%             switch culoare_chenar
%                 case 0 % chenar negru
%                     if (pixeliAlbi< pixeliNegrii)
%                         piesa = "alba";
%                         contor_piese_albe = contor_piese_albe+1;
%                         fprintf('chenarul %d contine o piesa %s.\n',k,piesa);
%                         disp("________________________________")
%                     else
%                         piesa = "neagra";
%                         contor_piese_negre = contor_piese_negre+1;
%                         fprintf('chenarul %d contine o piesa %s.\n',k,piesa);
%                         disp("________________________________")
%                     end
%                 case 1 % chenar alb
%                     if (pixeliAlbi> pixeliNegrii)
%                         piesa = "alba";
%                         contor_piese_albe = contor_piese_albe+1;
%                         fprintf('chenarul %d contine o piesa %s.\n',k,piesa);
%                         disp("________________________________")
%                     else
%                         piesa = "neagra";
%                         contor_piese_negre = contor_piese_negre+1;
%                         fprintf('chenarul %d contine o piesa %s.\n',k,piesa);
%                         disp("________________________________")
%                     end
%             end
            
        end
        % afisare pe rand a pieselor
        figure(6)
        imshow(chenar)
        title("chenar")
        pause(0.5)
        
    end
    
end

% afisare finala a chenarului, utila in cazul in care ultimul chenar este gol
% caz in care se trece la urmatoarea iteratie
figure(6)
title("chenar")
imshow(chenar)