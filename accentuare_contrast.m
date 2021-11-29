function ImagNou = accentuare_contrast(imag)
imag = uint8(imag);
%generare histograma
[L,C] = size (imag);
h = zeros(1, 255);

for i=1:L
    for j = 1:C
        I = imag(i,j);
        h(I+1) = h(I+1)+1;
    end
end

% histograma cumulativa
H = h;
for u=2:255
    H(u) = H(u-1)+h(u);
%     H(u) = sum(h(1:u);
end

% vectorul de transformare a histogramei
%varianta 1
T = H / (L*C)*255;
T = uint8(T);

ImagNou = imag;
for i=1:L
    for j = 1:C
        I = imag(i,j);
        ImagNou(i,j) = T(I+1);
    end
end

