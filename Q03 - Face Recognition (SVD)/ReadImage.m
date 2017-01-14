function im = ReadImage(address)

im = imread(address);
%im = imresize(im, 0.3);
im = im(1:6:size(im, 1), 1:6:size(im, 2), 1:size(im, 3));
im = rgb2gray(im);
im = im2double(im);