function im = ReadImage(address)

im = imread(address);
im = rgb2gray(im);
im = imresize(im, 0.25);
im = im2double(im);