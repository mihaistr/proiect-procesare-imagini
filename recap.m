% proiect 1
clc
clear 
close all

% N = zeros(20,20);
% A = ones (20);
% 
% I1 = [N,A,N,A,N];
% I2 = [A,N,A,N,A];
% I3 = [I1;I2;I1;I2;I1];
% %repmat cat
% % double valori intre 0 negru si 1 alb
% % uint8 0 negru si 255 alb
% 
% 
% figure(1)
% imshow(I3)
% 
% 
% 300x300

% P = [zeros(150,300);ones(150,300)];
% imshow(P')

%% 
% M = double(imread('download.jfif'));
M = imread('download.jfif');
imshow(M)

% R = M (:,:,1);
% G = M (:,:,2);
% B = M (:,:,3);
% 
% subplot(2,2,1)
% imshow(M)
% title ('original')
% 
% subplot(2,2,2)
% imshow(R)
% title ('Rosu')
% 
% subplot(2,2,3)
% imshow(G)
% title ('Verde')
% 
% subplot(2,2,4)
% imshow(B)
% title ('Albastru')

PatratAlb = M;
PatratAlb(1:(length(M)/2),1:(length(M))/2)) = 255;

figure()
imshow(PatratAlb)
title ('patrat alb')





