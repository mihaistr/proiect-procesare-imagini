function imag3 = filtrare_zgomot_sarepiper(imagPart2)

%% Imagine afectat? de zgomot de tip sare ?i piper

[M,N,S] = size (imagPart2);
imag3 = imagPart2;

for i = 2: M-1
    for j = 2: N-1
        crop  = imagPart2(i-1:i+1, j-1:j+1);
        V  = sort(crop(:)');
        imag3(i,j) = V(1,ceil(length(V)/2));
    end
end