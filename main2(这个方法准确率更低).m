%% ����ͼ����Ա�ʶ���㷨
%   ��ͼ����й�һ��Ԥ��������һ��������
fid1 = fopen('gender_name.csv');
filename = textscan(fid1, '%s');
label = csvread('gender_data.csv');
% Train_Number = 348;
% Test_Number = 231;
Train_Number = 400;
Test_Number = 179;
row = 286;
col= 200;
train_label = label(1:Train_Number,1);
test_label = label(Train_Number+1:579,1);
% ������ͼ����Ů��ͼ��ֱ���ȡ����
[T_male, T_female, mean_face] = GenderFaceVectorDatabase(filename,train_label,1, Train_Number);
fprintf('�Ѿ�������ѵ�����������T_male��,Ů��ѵ�����������T_female��.\n');
fprintf('�Ѿ�������ѵ�����������T��.\n');
fprintf('press any key to continue.\n');
pause;

% ��ʹ��pca��ͼ�����Ԥ����
[mean_f_face, mean_m_face, A, Eigenfaces] = EigenfacesSpaces2(T_male, T_female, row, col);

% ��ѵ����ͶӰ���������ռ���
ProjectedTrainImages = Projection2Eigenfaces(A, Eigenfaces);
ProjectedTrainImages = ProjectedTrainImages';

%% ʹ���Լ���д��֧���������㷨����������
%------------------------------ʹ��SVM����ѵ��-----------------------------
fprintf('%d %d\n',size(ProjectedTrainImages,1),size(ProjectedTrainImages,2));
fprintf('%d %d\n',size(train_label,1),size(train_label,2));
C = 3;
% gama = 1/(row *col);
gama = 20;
% model = svmTrainSelf(ProjectedTrainImages, train_label, C, @(x1, x2) gaussianKernel(x1, x2, gama));
model = svmTrainSelf(ProjectedTrainImages, train_label, C, @(x1, x2) gaussianKernel(x1, x2, gama));
fprintf('completing the svm training.\n');
fprintf('press any key to continue.\n');
pause;

%-------------------------------ʹ��SVM����Ԥ��----------------------------
% �������ͼ��
ProjectedTestImages = TestProjection2Eigenfaces(filename,mean_face,Train_Number+1,Test_Number, Eigenfaces);
ProjectedTestImages = ProjectedTestImages';
pred = svmPredictSelf(model, ProjectedTestImages);
correct_rate = sum((pred==test_label))/Test_Number;
fprintf('the correct rate of identifing the gender of images is %f\n',correct_rate);