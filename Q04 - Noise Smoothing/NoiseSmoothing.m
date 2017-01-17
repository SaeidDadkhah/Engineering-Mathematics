%% Init
clear

%% 1. Read image and add noise
inImage1 = im2double(imread('45.gif'));
inImage2 = im2double(imread('48.gif'));

noisyImage1 = inImage1 + ...
    normrnd(0, 20/255, size(inImage1, 1), size(inImage1, 1));
noisyImage2 = inImage2 + ...
    normrnd(0, 20/255, size(inImage2, 1), size(inImage2, 1));

%% 2. Decomposition
[u1, s1, v1] = svd(noisyImage1);
[u2, s2, v2] = svd(noisyImage2);

%% 3. Reconstruction with noise smoothing
r500_1 = u1(:, 1:500) * s1(1:500, 1:500) * v1(:, 1:500)';
r475_1 = u1(:, 1:475) * s1(1:475, 1:475) * v1(:, 1:475)';

r500_2 = u2(:, 1:500) * s2(1:500, 1:500) * v2(:, 1:500)';
r475_2 = u2(:, 1:475) * s2(1:475, 1:475) * v2(:, 1:475)';

%% Show images
subplot(2, 3, 1);
imshow(noisyImage1);
title('First Noisy Image');

subplot(2, 3, 2);
imshow(r500_1);
title('First Smoothed Image (500)');

subplot(2, 3, 3);
imshow(r475_1);
title('First Smoothed Image (475)');

subplot(2, 3, 4);
imshow(noisyImage2);
title('Second Noisy Image');

subplot(2, 3, 5);
imshow(r500_2);
title('Second Smoothed Image (500)');

subplot(2, 3, 6);
imshow(r475_2);
title('Second Smoothed Image (475)');

mseNoisy1 = mse2d(inImage1, noisyImage1);
mseR500_1 = mse2d(inImage1, r500_1);
mseR475_1 = mse2d(inImage1, r475_1);

mseNoisy2 = mse2d(inImage2, noisyImage2);
mseR500_2 = mse2d(inImage2, r500_2);
mseR475_2 = mse2d(inImage2, r475_2);

input('Press any key to continue...');

%% Show results
x = 5:10:511;
y = zeros(1, size(x, 2));
for i = 1:size(x, 2)
    y(i) = mse(inImage1, u1(:, 1:x(i)) * s1(1:x(i), 1:x(i)) * v1(:, 1:x(i))');
end
subplot(2, 1, 1);
plot(x, y);
title('First Image');

for i = 1:size(x, 2)
    y(i) = mse(inImage2, u2(:, 1:x(i)) * s2(1:x(i), 1:x(i)) * v2(:, 1:x(i))');
end
subplot(2, 1, 2);
plot(x, y);
title('Second Image');
