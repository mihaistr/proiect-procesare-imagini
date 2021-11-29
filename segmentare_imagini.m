% proiect sapt 4
clc
clear 
close all

% imag = im2uint8(imread('alunita.jpg'));
imag = im2uint8(imread('images.jfif'));
masca = logical(imread('masca.png'));

%convert to grayscale
% imagGray = rgb2gray(imag);
imagGray = 0.299 * imag(:,:,1) + 0.587 * imag(:,:,2)...
         + 0.114 * imag(:,:,3);

%generare histograma
values = 0:254;
[L,C,S] = size (imagGray);
H = zeros(1, 255);

for i=1:L
    for j = 1:C
        I = imag(i,j);
        H(I+1) = H(I+1)+1;
    end
end

prag = 100;

imagSegmentata = ones(L,C);

median = medfilt2(imagSegmentata,[2,2]);

imagSegmentata(imagGray>prag)=0;
imagSegmentata = logical(imagSegmentata);
figure()
subplot(2,2,1)
title('incarcata rgb')
imshow(imag)
subplot(2,2,2)
title('grayscale')
imshow(imagGray)
subplot(2,2,3)
imshow(imagSegmentata)
title ('imagSegmentata')
subplot(2,2,4)
imshow(median)
title ('masca')

% figure()
% bar(values,H)
% grid

% vectorimagSegmentata = imagSegmentata (:);
% vectorMasca = masca(:);
% C = confusionmat (vectorMasca,vectorimagSegmentata)
% TPR = C(2,2) / (C(2,1)+C(2,2))*100
% TNR = C(1,1) / (C(1,1)+C(1,2))*100
% ACC = (TPR+TNR)/2









