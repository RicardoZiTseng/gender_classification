function [mean_face, A, Eigenfaces] = EigenfacesSpaces(T, row, col)
%��������Ĺ���������ѵ������ƽ����mean_face,
%ѵ������ƽ�����Ĳ�ֵ����A���Լ�ѵ�������������ռ�Eigenfaces
%% ����ƽ����

mean_face = mean(T, 2);
mean_face_reshape = reshape(mean_face, row, col);
Image_mean = mat2gray(mean_face_reshape);
imwrite(Image_mean, 'meanface.jpg','jpg');

%������ƽ�����Ĳ�ֵ����
A = [];
Train_Number = size(T,2);
for i=1:Train_Number
    temp = double(T(:,i)) - mean_face;
    A = [A temp];
end
L = A' * A;
[U,S] = eig(L);

%% ��ѡȡ���������������������ռ��ת������
L_eig_vec = [];
for i=1:size(U,2)
   if(S(i,i)>1)
       L_eig_vec = [L_eig_vec U(:,i)];
   end
end
fprintf('%d %d\n',size(A,1), size(A,2));
fprintf('%d %d\n',size(L_eig_vec,1),size(L_eig_vec,2));
pause;
Eigenfaces = A * L_eig_vec;
% fprintf('%d %d\n',size(Eigenfaces,1),size(Eigenfaces,2));
% fprintf('%d %d',row, col);
end