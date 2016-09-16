function [img_output, img_BW] = kmeans(img_rgb, img_bw)
img_rgb = double(img_rgb);
[row, col, dim] = size(img_rgb);
if dim ~= 3
    return;
end

img_r = img_rgb(:, :, 1);
img_g = img_rgb(:, :, 2);
img_b = img_rgb(:, :, 3);

pos_skin = find(img_bw == 1);                       % Æ¤·ô
r_center = sum( sum( img_r(pos_skin) ) ) / size(pos_skin, 1);
g_center = sum( sum( img_g(pos_skin) ) ) / size(pos_skin, 1);
b_center = sum( sum( img_b(pos_skin) ) ) / size(pos_skin, 1);
skin_center = [r_center, g_center, b_center];

pos_other = find(img_bw == 0);                      % ÆäËû
r_center = sum( sum( img_r(pos_other) ) ) / size(pos_other, 1);
g_center = sum( sum( img_g(pos_other) ) ) / size(pos_other, 1);
b_center = sum( sum( img_b(pos_other) ) ) / size(pos_other, 1);
other_center = [r_center, g_center, b_center];

img_BW = zeros(row, col);

for i = 1 : row
    for j = 1 : col
        img_point = [img_r(i, j), img_g(i, j), img_g(i, j)];
        if sum( (skin_center - img_point) .^ 2 ) < sum( (other_center - img_point) .^ 2 )
            img_BW(i, j) = 1;                       % Æ¤·ô
        end
    end
end

pos_skin = find(img_BW == 0);
img_r(pos_skin) = 0;
img_g(pos_skin) = 0;
img_b(pos_skin) = 0;
img_output(:, :, 1) = img_r;
img_output(:, :, 2) = img_g;
img_output(:, :, 3) = img_b;