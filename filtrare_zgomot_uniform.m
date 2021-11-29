function imag_filtrata_uniform = filtrare_zgomot_uniform(imagPart1)
%% Imagine afectat? de zgomot uniform

[M,N] = size (imagPart1);

n = 1;
masca = 1/(n+2)^2*[1 n 1;n n^2 n; 1 n 1];
imag_filtrata_uniform = imagPart1;
for i = 2: M-1
    for j = 2: N-1
        crop  = imagPart1(i-1:i+1, j-1:j+1);
        imag_filtrata_uniform(i,j) = sum(sum(crop .* masca));
    end
end
