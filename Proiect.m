clc
clear all
close all

%% incarcare imagine
imagIncarcata = rgb2gray(im2double(imread('tema17.png')));
% imagIncarcata = rgb2gray(im2double(imread('images.jfif')));
% imagIncarcata = rgb2gray(im2double(imread('download.png')));

% imagIncarcata = filtrare_zgomot_sarepiper(imagIncarcata);
%  imagIncarcata = filtrare_zgomot_uniform(imagIncarcata);

% figure(1)
% imshow(imagIncarcata)

%% dimensiuni imagine
[Lini,Coloane] = size (imagIncarcata);

%% binarizarea imagini incarcate;
prag = 0.55;
imagBinarizata = ones(Lini,Coloane);
imagBinarizata(imagIncarcata < prag) = 0;
imagBinarizata = logical(imagBinarizata);

% figure(2)
% title("imag incarcat binar")
% imshow(imagBinarizata)

%% aplicare filtru sare piper pe imag binarizata
imagBinarizata2 = filtrare_zgomot_sarepiper(imagBinarizata);
figure(3)
title("imag incarcat binar")
imshow(imagBinarizata2)

%% aflare margine tabla
margine_tabla_L = length(find(imagBinarizata2(Lini-10,1:10) == 1 ));
margine_tabla_C = length(find(imagBinarizata2(Lini-10:Lini,10) == 1 ));

%% aflare numar si coloane un chenar
LiniiUnPatrat = ceil((Lini-margine_tabla_L*2)/8);
ColoaneUnPatrat = ceil((Coloane-margine_tabla_C*2)/8);

chenar = zeros(Lini,Coloane);
culoare_chenar = 1; % 1-alb, 0-negru ; impar alb, par negru

% L = margine_tabla_L ;
% C = margine_tabla_C;

contor_piese_negre = 0;
contor_piese_albe = 0;

ArieCheanr = ColoaneUnPatrat*LiniiUnPatrat;

for L = margine_tabla_L:LiniiUnPatrat:Lini-LiniiUnPatrat
    for C = margine_tabla_C:ColoaneUnPatrat:Coloane-ColoaneUnPatrat
        %%
        for l = L:LiniiUnPatrat+L-1
            for c = C:ColoaneUnPatrat+C-1
                chenar(l,c) = imagBinarizata2(l,c);
                %                 if chenar(l,c)== 0
                %                     pixeliNegrii = pixeliNegrii + 1;
                %                 else
                %                     pixeliAlbi = pixeliAlbi + 1;
                %                 end
            end
        end
        
        mijlocChenar = chenar(l/2-5:l/2+5,c/2-5:c/2+5);
        pixeliAlbi = numel(find(mijlocChenar == 1));
        pixeliNegrii = numel(find(mijlocChenar == 0));
        
        z=mod(culoare_chenar,2);
        
        if (pixeliAlbi == numel(mijlocChenar)) || (pixeliAlbi == numel(mijlocChenar))
            piesa = "nu E piesa";
%             return;
        end
        
        if (pixeliAlbi < pixeliNegrii)
            piesa = "neagra";
            contor_piese_negre = contor_piese_negre+1;
        end
        if (pixeliAlbi > pixeliNegrii)
            piesa = "alba";
            contor_piese_albe = contor_piese_albe+1;
        end
        
%         switch z
%             case 1 % negru
%                 
%             case 0 % alb
%         end
%         culoare_chenar = culoare_chenar+1;
        
        pixeliNegrii = 0;
        pixeliAlbi = 0;
    end
end

figure(6)
imshow(chenar)
