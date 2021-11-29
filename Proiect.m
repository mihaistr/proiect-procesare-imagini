clc
clear
close all

%% incarcare imagine
% imagIncarcata = rgb2gray(im2double(imread('tema17.png')));
imagIncarcata = rgb2gray(im2double(imread('images.jfif')));
% imagIncarcata = rgb2gray(im2double(imread('download1.png')));

% imagIncarcata = filtrare_zgomot_sarepiper(imagIncarcata);
%  imagIncarcata = filtrare_zgomot_uniform(imagIncarcata);

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
margine_tabla_L = numel(find(imagSegmentata(Lini-10,1:10) == 1 ));
margine_tabla_C = length(find(imagSegmentata(Lini-10:Lini,10) == 1 ));

%% aflare numar si coloane un chenar
LiniiUnPatrat = ceil((Lini-margine_tabla_L*2)/8);
ColoaneUnPatrat = ceil((Coloane-margine_tabla_C*2)/8);

chenar = zeros(Lini,Coloane);
culoare_chenar = 1; % 1-alb, 0-negru ; impar alb, par negru

% L = margine_tabla_L ;
% C = margine_tabla_C;

contor_piese_negre = 0;
contor_piese_albe  = 0;
contor_chenare_negre_libere = 0;
contor_chenare_albe_libere = 0;

ArieCheanr = ColoaneUnPatrat*LiniiUnPatrat;
k = 0;

for L = margine_tabla_L:LiniiUnPatrat:Lini-LiniiUnPatrat
    for C = margine_tabla_C:ColoaneUnPatrat:Coloane-ColoaneUnPatrat
        %%
%         if k==64
%             return;
%         end
        k = k+1;
        z=mod(culoare_chenar,2);
        z = z+1;
        
        for l = L+1:LiniiUnPatrat+L-1
            for c = C+1:ColoaneUnPatrat+C-1
                chenar(l,c) = imagSegmentata(l,c);
            end
        end
        
        
        lm = floor(LiniiUnPatrat/3);
        cm = floor(ColoaneUnPatrat/3);


        %        mijlocChenar = chenar(l-ceil(LiniiUnPatrat/2)-10:l-ceil(LiniiUnPatrat/2)+10,c-ceil(ColoaneUnPatrat/2)-10:c-ceil(ColoaneUnPatrat/2)+10);
%                 mijlocChenar = chenar(l-LiniiUnPatrat+2:l-4,c-ceil(ColoaneUnPatrat/2)-1:c-ceil(ColoaneUnPatrat/2)+1);
%        mijlocChenar = chenar(l-ceil(LiniiUnPatrat/4)-floor(LiniiUnPatrat/4):l-ceil(LiniiUnPatrat/4)+floor(LiniiUnPatrat/4),...
%             c-ceil(ColoaneUnPatrat/4)-floor(ColoaneUnPatrat/4):c-ceil(ColoaneUnPatrat/4)+floor(ColoaneUnPatrat/4));
%         mijlocChenar = chenar(l-LiniiUnPatrat+lm:l-lm,cx-2:cx+2);

        pixeliAlbi = numel(find(mijlocChenar == 1));
        pixeliNegrii = numel(find(mijlocChenar == 0));
        
        if (pixeliAlbi == numel(mijlocChenar))
            tip_chenar = "chenar alb gol";
            contor_chenare_albe_libere = contor_chenare_albe_libere+1;
            disp("chenarul alb")
            disp(k)
            disp("este gol")
            disp("---------")
            continue
        end
        
        if (pixeliNegrii == numel(mijlocChenar))
            tip_chenar = "chenar negru gol";
            contor_chenare_negre_libere = contor_chenare_negre_libere+1;
            disp("chenarul negru")
            disp(k)
            disp("este gol")
            disp("---------")
            continue
        end
        
        if (pixeliAlbi ~= pixeliNegrii)
            tip_chenar = "cu piesa";
            if (pixeliAlbi> pixeliNegrii)
                piesa = "alba";
                contor_piese_albe = contor_piese_albe+1;
                disp("piesa alba pe chenarul")
                disp(k)
                disp("---------")
            else
                piesa = "neagra";
                contor_piese_negre = contor_piese_negre+1;
                disp("piesa neagra pe chenarul")
                disp(k)
                disp("---------")
            end
        end
        
        
        
        figure(6)
        imshow(chenar)
%         pause(0.5)
        
    end
    
end


figure(6)
imshow(chenar)