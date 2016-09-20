clc;clear;close all;

[filename, pathname] = uigetfile('../image/*.*', '¶ÁÈ¡Í¼Æ¬ÎÄ¼þ');
pathfile = fullfile(pathname, filename);
if filename == 0
    return;
end
img_rgb = imread(pathfile);
if size(img_rgb) ~= 3
    return;
end
% img_rgb = grayworld2(img_rgb, 1);

r = img_rgb(:, :, 1);
g = img_rgb(:, :, 2);
b = img_rgb(:, :, 3);
zerpos = find(r == 0 & g == 0 & b == 0);

[img_skin, img_bw] = SkinDetecte(img_rgb);
[img_result1, img_bw] = kmeans(img_rgb, img_bw);
[img_result2, img_bw] = kmeans(img_rgb, img_bw);
[img_result3, img_bw] = kmeans(img_rgb, img_bw);
[img_result4, ~] = kmeans(img_rgb, img_bw);
 figure;imshow([img_rgb, img_skin, img_result1; img_result2, img_result3, img_result4]);

img_gray = rgb2gray( uint8(img_skin) );
% img_gray = rgb2gray( uint8(img_result4) );
img_bw = im2bw( img_gray, graythresh(img_gray) );

img_bw = Remove_Spot(img_bw);

se = strel('disk', 11);
img_bw = imdilate(img_bw, se, 5);

img_bw = imerode( img_bw, strel('disk', 11) );

% img_bw = Remove_Spot(1 - img_bw);
% img_bw = uint8(1 - img_bw);
pos = find(img_bw == 0);

r(pos) = 255;
r(zerpos) = 0;
g(pos) = 0;
b(pos) = 0;

img_res(:, :, 1) = r;
img_res(:, :, 2) = g;
img_res(:, :, 3) = b;

figure;imshow([img_rgb, img_res]);
