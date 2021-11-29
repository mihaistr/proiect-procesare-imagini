function imag_Laplace = extragere_contur (imagIncarcata)
% 4. Operatorul Laplace
[linii,coloane] = size (imagIncarcata);

h_laplace = [0 1 0; 1 -4 1; 0 1 0]; 
% sau
% h2_laplace = [-1 -1 -1; -1 8 -1; -1 -1 -1];

imag_Laplace = imagIncarcata;
for i = 2: linii - 1
    for j = 2: coloane - 1
        crop  = imagIncarcata(i-1:i+1, j-1:j+1);
        imag_Laplace(i,j) = sum(sum(crop.*h_laplace));
    end
end

