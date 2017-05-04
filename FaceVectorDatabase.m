function T = FaceVectorDatabase( filename, Start_Number, Train_Number )
%filename是所有图片的文件名，将Train_Number数量的图片组合成一个矩阵
T = [];
img = imread(filename{1}{1});
for i = Start_Number:Start_Number + Train_Number - 1
    imgname = filename{1}{i};
    image_new = ResizeImage(imgname);
    temp = image_new';
    temp = temp(:);
    T = [T temp];
end

end

