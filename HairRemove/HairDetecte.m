function img_bw = HairDetecte(img_rgb, r, g, b, row, col)
img_bw = zeros(row, col);
pos_zeros = ( r <= 2 & g <= 2 & b <= 2 );

img_YCbCr = rgb2ycbcr(img_rgb);
Cb = img_YCbCr(:, :, 2);
Cr = img_YCbCr(:, :, 3);

pos_hair =  ( Cb >= 115 & Cb <= 141 & Cr >= 115 & Cr <= 143 & r < 120 );

img_bw(pos_hair) = 1;
img_bw(pos_zeros) = 0;