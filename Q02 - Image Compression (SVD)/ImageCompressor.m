function res = ImageCompressor(image, rank)

res = zeros(size(image, 1), size(image, 2), size(image, 3));
for i = 1:size(image, 3)
    [u, s, v] = svd(image(:, :, i));
    res(:, :, i) = u(:, 1:rank) * s(1:rank, 1:rank) * v(:, 1:rank)';
end