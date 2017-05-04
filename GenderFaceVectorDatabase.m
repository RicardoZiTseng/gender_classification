function [T_male, T_female,mean_face] = GenderFaceVectorDatabase(filename,label,Start_Number, Train_Number)
%
T = [];
T_male = [];
T_female = [];
for i = Start_Number : Start_Number + Train_Number - 1
    imgname = filename{1}{i};
    image_new = ResizeImage(imgname);
    temp = image_new';
    temp = temp(:);
    if label(i) == 1
        T_female = [T_female temp];
    else
        T_male = [T_male temp];
    end
    T = [T temp];
end
mean_face = mean(T, 2);
end

