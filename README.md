# gender classification
gender classification

在完成利用pca实现人脸识别的算法之后，我进一步研究了如何利用pca与svm实现性别识别的算法。

做出来之后我发现自己的程序的性别识别率比较低，大概只有60%左右，目前还不清楚原因，姑且把性别识别的源代码贴出来。下面是我的程序结构：

- main1.m 
  性别识别主程序，直接打开这个文件运行
- FaceVectorDatabase.m 
  将训练集图像提取为一个矩阵
- ResizeImage.m 
  将图像转换为灰度图像，并归一化为286*200分辨率的图像
- EigenfacesSpaces.m 生成训练集的平均脸mean_face,训练集与平均脸的差值矩阵A，以及训练集的特征脸空间Eigenfaces
- Projection2Eigenfaces.m 将训练集投影到特征空间上
-  TestProjection2Eigenfaces.m 将测试图像投影到特征空间上，并存储为一个矩阵
- svmTrainSelf.m 利用svm训练
- svmPredictSelf.m 利用svm做预测
- main2(这个方法准确率更低).m 这是我自己突发奇想的一个算法，其实就只是分别计算男性与女性的平均脸，然后生成各自的差值矩阵，并投影到整个训练集的特征空间上进行svm的训练，不过准确率好像变得更低了2333
- GenderFaceVectorDatabase.m 提取男性训练集与女性训练集，并计算训练集的平均脸
- EigenfacesSpaces2.m 针对main2.m的一个特征空间计算算法

人脸数据集已经被我放到网盘上了，整个程序是基于这个训练集完成的

- [传送门](http://pan.baidu.com/s/1nvRsWjf)

如果无法下载的话，或者有什么建议的话请发邮件给我(1941651789@qq.com)
