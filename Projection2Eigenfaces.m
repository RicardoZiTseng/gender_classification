function [ProjectedImages] = Projection2Eigenfaces( A ,Eigenfaces )
%��ѵ����ͶӰ�������ռ���
ProjectedImages = [];
Train_Number = size(A, 2);
for i=1:Train_Number
   temp = Eigenfaces' * A(:,i);
   ProjectedImages = [ProjectedImages temp];
end

end

