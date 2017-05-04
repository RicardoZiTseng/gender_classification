function [ProjectedImages] = Projection2Eigenfaces( A ,Eigenfaces )
%将训练集投影到特征空间上
ProjectedImages = [];
Train_Number = size(A, 2);
for i=1:Train_Number
   temp = Eigenfaces' * A(:,i);
   ProjectedImages = [ProjectedImages temp];
end

end

