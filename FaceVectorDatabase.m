function T = FaceVectorDatabase( filename, Start_Number, Train_Number )
%filename������ͼƬ���ļ�������Train_Number������ͼƬ��ϳ�һ������
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

