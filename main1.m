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
T = FaceVectorDatabase(filename, 1, Train_Number);
fprintf('%d %d',size(T,1),size(T,2));
fprintf('�Ѿ���ѵ�����������T��.\n');
fprintf('press any key to continue.\n');
pause;

% ��ʹ��pca��ͼ�����Ԥ����
[mean_face, A, Eigenfaces] = EigenfacesSpaces(T, row, col);
fprintf('We has already calculated the eigenfaces space\n');
fprintf('press any key to continue.\n');
pause;

% ��ѵ����ͶӰ���������ռ���
fprintf('��ѵ����ͶӰ���������ռ���\n')
fprintf('press any key to continue.\n');
pause;
ProjectedTrainImages = Projection2Eigenfaces(A, Eigenfaces);
% Ȼ��Ծ���ת�ã�������svmѵ����
ProjectedTrainImages = ProjectedTrainImages';
fprintf('�Ѿ�������ת��\n');
fprintf('press any key to continue.\n');
pause;

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
% [T_test, row_test, col_test] = FaceVectorDatabase(filename, Train_Number+1, Test_Number);
ProjectedTestImages = TestProjection2Eigenfaces(filename,mean_face,Train_Number+1,Test_Number, Eigenfaces);
ProjectedTestImages = ProjectedTestImages';
pred = svmPredictSelf(model, ProjectedTestImages);
correct_rate = sum((pred==test_label))/Test_Number;
fprintf('the correct rate of identifing the gender of images is %f\n',correct_rate);

%% ʹ��matlab�ڲ���svm��������з����������⣨�ðɣ��Ҳ����ã��������������⣩
% X = ProjectedTrainImages;
% Y = train_label;
% svmStruct = svmtrain(X, Y, 'rbf');
% fprintf('completing the svm training.\n');
% fprintf('press any key to continue.\n');
% pause;
% 
% ProjectedTestImages = TestProjection2Eigenfaces(filename,mean_face,Train_Number+1,Test_Number, Eigenfaces);
% ProjectedTestImages = ProjectedTestImages';
% species = svmclassify(svmStruct, ProjectedTestImages);
% correct_rate = sum(species == test_label)/Test_Number;
% fprintf('the correct rate of identifing the gender of images is %f\n',correct_rate);