clc
clear 
close all 

% arata de ce e bine sa mediez imaginea ininte de segmentare
% pentru a scapa de piesele negre pe fundal negru

imagIncarcata = rgb2gray(im2double(imread('tema17.png')));
figure()
title("imag incarcat binar")
imshow(imagIncarcata)

%% aplicare filtru sare piper pe imag binarizata
imagBinarizata = filtrare_zgomot_uniform(imagIncarcata);
figure()
title("imag incarcat binar")
imshow(imagBinarizata)

%% segmentarea imaginii
imagSegmentata = segmentare(imagIncarcata);
figure()
imshow(imagSegmentata)


%% segmentarea imaginii2
imagSegmentata2 = segmentare(imagBinarizata);
figure()
imshow(imagSegmentata2)




