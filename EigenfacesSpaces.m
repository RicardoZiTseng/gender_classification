function [mean_face, A, Eigenfaces] = EigenfacesSpaces(T, row, col)
%这个函数的功能是生成训练集的平均脸mean_face,
%训练集与平均脸的差值矩阵A，以及训练集的特征脸空间Eigenfaces
%% 计算平均脸

mean_face = mean(T, 2);
mean_face_reshape = reshape(mean_face, row, col);
Image_mean = mat2gray(mean_face_reshape);
imwrite(Image_mean, 'meanface.jpg','jpg');

%人脸与平均脸的差值矩阵
A = [];
Train_Number = size(T,2);
for i=1:Train_Number
    temp = double(T(:,i)) - mean_face;
    A = [A temp];
end
L = A' * A;
[U,S] = eig(L);

%% 将选取的特征向量构成特征脸空间的转换矩阵
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