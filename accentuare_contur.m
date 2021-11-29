function imagUnsharp = accentuare_contur(imagIncarcata)

% 3a.Tehnica unsharp masking

% medierea imaginii
n = 1;
masca = 1/(n+2)^2*[1 n 1;n n^2 n; 1 n 1];

imagMediata = imagIncarcata;
[L,C] = size (imagIncarcata);
for i = 2: L-1
    for j = 2: C-1
        crop  = imagIncarcata(i-1:i+1, j-1:j+1);
        imagMediata(i,j) = sum(sum(crop .* masca));
       
    end
end

% c = [0.6,0.8];
c = 3;
a = 2;

% varianta fara for
imagUnsharp = c*imagIncarcata - a*imagMediata;