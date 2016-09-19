function [img_hair, img_bw] = HairDetecte(img_rgb)
[row, col, dim] = size(img_rgb);

r = img_rgb(:, :, 1);
g = img_rgb(:, :, 2);
b = img_rgb(:, :, 3);

img_YCbCr = rgb2ycbcr(img_rgb);
Y = img_YCbCr(:, :, 1);
Cb = img_YCbCr(:, :, 2);
Cr = img_YCbCr(:, :, 3);

img_hair = uint8( zeros(row, col, dim) );
img_bw = uint8( zeros(row, col) );

pos_hair = find( Cb >= 115 & Cb <= 141 & Cr >= 115 & Cr < 143 & r < 150 );

img_bw(pos_hair) = 1;

img_hair(:, :, 1) = r .* img_bw;
img_hair(:, :, 2) = g .* img_bw;
img_hair(:, :, 3) = b .* img_bw;