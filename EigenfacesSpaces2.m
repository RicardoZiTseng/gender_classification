function [mean_f_face, mean_m_face, A, Eigenfaces] = EigenfacesSpaces2(T_male, T_female, row, col)
%
mean_f_face = mean(T_female,2);
mean_m_face = mean(T_male, 2);
temp_m = repmat(mean_m_face, 1, size(T_male,2));
temp_f = repmat(mean_f_face, 1, size(T_female,2));
T_male = double(T_male) - temp_m;
T_female = double(T_female) - temp_f;
A = [T_male T_female];
L = A' * A;
[U, S] = eig(L);

L_eig_vec = [];
for i=1:size(U,2)
   if(S(i,i)>1)
       L_eig_vec = [L_eig_vec U(:,i)];
   end
end
Eigenfaces = A * L_eig_vec;
end

