function im = ReadImage(address)

im = imread(address);
im = imresize(im, 0.2);
%im = im(1:5:size(im, 1), 1:5:size(im, 2), 1:size(im, 3));
im = rgb2gray(im);
im = im2double(im);