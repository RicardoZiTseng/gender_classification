%% 基于图像的性别识别算法
%   对图像进行归一化预处理并放入一个矩阵中
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
% 将男性图像与女性图像分别提取出来
[T_male, T_female, mean_face] = GenderFaceVectorDatabase(filename,train_label,1, Train_Number);
fprintf('已经将男性训练集放入矩阵T_male中,女性训练集放入矩阵T_female中.\n');
fprintf('已经将所有训练集放入矩阵T中.\n');
fprintf('press any key to continue.\n');
pause;

% 先使用pca对图像进行预处理
[mean_f_face, mean_m_face, A, Eigenfaces] = EigenfacesSpaces2(T_male, T_female, row, col);

% 将训练集投影到特征脸空间上
ProjectedTrainImages = Projection2Eigenfaces(A, Eigenfaces);
ProjectedTrainImages = ProjectedTrainImages';

%% 使用自己编写的支持向量机算法作分类问题
%------------------------------使用SVM进行训练-----------------------------
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

%-------------------------------使用SVM进行预测----------------------------
% 处理测试图像集
ProjectedTestImages = TestProjection2Eigenfaces(filename,mean_face,Train_Number+1,Test_Number, Eigenfaces);
ProjectedTestImages = ProjectedTestImages';
pred = svmPredictSelf(model, ProjectedTestImages);
correct_rate = sum((pred==test_label))/Test_Number;
fprintf('the correct rate of identifing the gender of images is %f\n',correct_rate);