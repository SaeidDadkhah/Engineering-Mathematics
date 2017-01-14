%% init
%{
clear

%% 1. Read data set
address = 'Dataset/';

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

%% 2. Normalize
meanOfA = mean(A, 2);
A = A - meanOfA(:, ones(1, N));

%% 3. SVD
[u, s, v] = svd(A);
R = size(s, 1);

%% 4. Coordinate x_i
xi = u(:, 1:10)' * A;
%}

%% 5. Choose threshold

%% 6. Projection
efs = zeros(20, 1);

ei = zeros(20, N);
class = -1 * ones(N, 1);
for i = 1:20
    f = ReadImage(sprintf('Dataset/%d-11.jpg', i));
    f = f(:) - meanOfA;
    x = u(:, 1:10)' * f;
    
    ef = f - u(:, 1:10) * x;
    efs(i) = (ef' * ef) ^ .5;
    
    %% 7. Classify
    for j = 1:N
        tmp = xi(:, j) - x;
        ei(i, j) = tmp' * tmp;
    end
    
end
plot(efs, '-o')
%[m, i] = min(tmp);
