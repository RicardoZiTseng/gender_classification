function [imagenew] = ResizeImage(image_name)
% ��ͼ���һ��������Ϊ286*200�ֱ��ʵ�ͼ��
image = imread(image_name);
imagenew = imresize(image,[286,200]);
imagenew = rgb2gray(imagenew);
end

