%% init
clear

%% 1. Read data set
address = 'Dataset/';
curDir = dir(address);

inImage = ReadImage(sprintf('%s%s', address, '1-04.jpg'));
M  = size(inImage(), 1) * size(inImage(), 2);
N = 60;
A = zeros(M, N);
for i = 1:10
    for j = [4 5 6 7 11 13]
        f = ReadImage(sprintf('%s%d-%02d.jpg', address, i, j));
        A(:, i) = f(:);
    end
end
%{
address = 'frontalimages_manuallyaligned_part1/b/';
curDir = dir(address);
for i = 1:(N/2)
    f = ReadImage(sprintf('%s%s', address, curDir(i + 2).name));
    A(:, i) = f(:);
end
%}

%% 2. Normalize
meanOfA = mean(A, 2);
A = A - meanOfA(:, ones(1, N));

%% 3. SVD
[u, s, v] = svd(A);
R = size(s, 1);

%% 4. Coordinate x_i
coordinateX = u(:, 1:R)' * A;

%% 6. Projection
efs = zeros(20, 1);
for i = 1:20
    f = ReadImage(sprintf('Dataset/%d-11.jpg', i));
    f = f(:);
    x = u(:, 1:R)' * (f - meanOfA);

    ef = f - meanOfA - u(:, 1:R) * x;
    efs(i) = (ef' * ef) ^ .5;
end
plot(efs, '-o')
%[m, i] = min(tmp);
