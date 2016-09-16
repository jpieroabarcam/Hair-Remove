clc;clear;close all;

% img_rgb = imread('eyes.png');
img_rgb = imread('face.jpg');
[m, n, dim] = size(img_rgb);

R = img_rgb(:, :, 1);
G = img_rgb(:, :, 2);
B = img_rgb(:, :, 3);

r = 10;
Y = 10;

img_r = zeros(m, n);
img_g = zeros(m, n);
img_b = zeros(m, n);

for row = 1 : m
    for col = 1 : n
        pos = [row - r, row + r, col - r, col + r]; % up down left right
        pos(pos < 1) = 1;
        if pos(1, 2) > m
            pos(1, 2) = m;
        end
        if pos(1, 4) > n
            pos(1, 4) = n;
        end
        
        patchR = R(pos(1, 1) : pos(1, 2), pos(1, 3) : pos(1, 4));
        top = sum( sum( ( 1 - ( abs( patchR - R(row, col) ) ./ (2.5 * Y) ) ) .* patchR ) );
        buttom = sum( sum( 1 - ( abs( patchR - R(row, col) ) ./ (2.5 * Y) ) ) );
        img_r(row, col) = top / buttom;
        
        patchG = G(pos(1, 1) : pos(1, 2), pos(1, 3) : pos(1, 4));
        top = sum( sum( ( 1 - ( abs( patchG - G(row, col) ) ./ (2.5 * Y) ) ) .* patchG ) );
        buttom = sum( sum( 1 - ( abs( patchG - G(row, col) ) ./ (2.5 * Y) ) ) );
        img_g(row, col) = top / buttom;
        
        patchB = B(pos(1, 1) : pos(1, 2), pos(1, 3) : pos(1, 4));
        top = sum( sum( ( 1 - ( abs( patchB - B(row, col) ) ./ (2.5 * Y) ) ) .* patchB ) );
        buttom = sum( sum( 1 - ( abs( patchB - B(row, col) ) ./ (2.5 * Y) ) ) );
        img_b(row, col) = top / buttom;
    end
end

img_result(:, :, 1) = img_r;
img_result(:, :, 2) = img_g;
img_result(:, :, 3) = img_b;

img_result = uint8(img_result);

figure;
imshow( [img_rgb, img_result, abs(img_rgb - img_result)] );