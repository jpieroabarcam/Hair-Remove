function [img_skin, img_bw] = SkinDetecte(img_rgb)
[row, col, dim] = size(img_rgb);

r = img_rgb(:, :, 1);
g = img_rgb(:, :, 2);
b = img_rgb(:, :, 3);

img_skin = uint8( zeros(row, col, dim) );
img_bw = uint8( zeros(row, col) );

pos_skin = find( r > 95 & g > 40 & b > 20 & r > g & r > b & max( max(r, b), g) - min( min(r, b), g ) > 15 & abs(r - g) > 15 );

img_bw(pos_skin) = 1;

img_skin(:, :, 1) = r .* img_bw;
img_skin(:, :, 2) = g .* img_bw;
img_skin(:, :, 3) = b .* img_bw;

