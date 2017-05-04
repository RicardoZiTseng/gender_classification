function [imagenew] = ResizeImage(image_name)
% 将图像归一化处理，变为286*200分辨率的图像
image = imread(image_name);
imagenew = imresize(image,[286,200]);
imagenew = rgb2gray(imagenew);
end

