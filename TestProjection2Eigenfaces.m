function [ ProjectedTestImages ] = TestProjection2Eigenfaces(filename, mean_face, StartNumber, Test_Number, Eigenfaces)
%������ͼ��ͶӰ�������ռ���
ProjectedTestImages = [];
for i=StartNumber:StartNumber+Test_Number-1
    InputTestName = filename{1}{i};
    InputTestImage = ResizeImage(InputTestName);
    temp = InputTestImage';
    temp = temp(:);
    Difference = double(temp) - mean_face;
    ProjectedTemp= Eigenfaces' * Difference;
    ProjectedTestImages = [ProjectedTestImages ProjectedTemp];
end
end

