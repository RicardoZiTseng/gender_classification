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
T = FaceVectorDatabase(filename, 1, Train_Number);
fprintf('%d %d',size(T,1),size(T,2));
fprintf('已经将训练集放入矩阵T中.\n');
fprintf('press any key to continue.\n');
pause;

% 先使用pca对图像进行预处理
[mean_face, A, Eigenfaces] = EigenfacesSpaces(T, row, col);
fprintf('We has already calculated the eigenfaces space\n');
fprintf('press any key to continue.\n');
pause;

% 将训练集投影到特征脸空间上
fprintf('将训练集投影到特征脸空间上\n')
fprintf('press any key to continue.\n');
pause;
ProjectedTrainImages = Projection2Eigenfaces(A, Eigenfaces);
% 然后对矩阵转置，方便用svm训练；
ProjectedTrainImages = ProjectedTrainImages';
fprintf('已经将矩阵转制\n');
fprintf('press any key to continue.\n');
pause;

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
% [T_test, row_test, col_test] = FaceVectorDatabase(filename, Train_Number+1, Test_Number);
ProjectedTestImages = TestProjection2Eigenfaces(filename,mean_face,Train_Number+1,Test_Number, Eigenfaces);
ProjectedTestImages = ProjectedTestImages';
pred = svmPredictSelf(model, ProjectedTestImages);
correct_rate = sum((pred==test_label))/Test_Number;
fprintf('the correct rate of identifing the gender of images is %f\n',correct_rate);

%% 使用matlab内部的svm工具箱进行分类问题的求解（好吧，我不会用，反正程序有问题）
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