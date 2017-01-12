%% init
clear

%% Read data set
address = 'frontalimages_manuallyaligned_part1/a/';
curDir = dir(address);

inImage = imread(sprintf('%s%s', address, curDir(3).name));
inImage = imresize(inImage, 0.2);
M  = size(inImage(), 1) * size(inImage(), 2);
N = size(curDir, 1) - 2;
A = zeros(M, N);
for i = 1:N
    tmp = im2double(...
        rgb2gray(...
        imread(sprintf('%s%s', address, curDir(i + 2).name))));
    tmp = imresize(tmp, 0.2);
    A(:, i) = tmp(:);
end

%% Normalize
meanOfA = mean(A, 2);
A = A - meanOfA(:, ones(1, N));

%% SVD
[u, s, v] = svd(A);
