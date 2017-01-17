function mse = mse2d(i1, i2)

mse = sum(sum(sum((i1 - i2) .^ 2))) / size(i1, 1) / size(i1, 2) / size(i1, 3);