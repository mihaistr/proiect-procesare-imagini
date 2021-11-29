function imagNou = filtrare_zgomot(imag)

% Imagine afectat? de zgomot de tip sare ?i piper
imag = double(imag);

[M,N] = size (imag);
imagNou = imag;
n = 1;
masca = 1/(n+2)^2*[1 n 1;n n^2 n; 1 n 1];
for i = 2: M-1
    for j = 2: N-1
        crop  = imag(i-1:i+1, j-1:j+1);
%         V  = sort(crop(:)');
%         imagNou(i,j) = V(1,ceil(length(V)/2));
        imagNou(i,j) = sum(sum(crop .* masca));
    end
end
