clc;clear;close all;
img_rgb = imread('eyes.png');
% img_rgb = imread('baby.jpg');
% img_rgb = imread('famale.jpg');
% img_rgb = imread('face.jpg');

[img_skin, img_bw] = SkinDetecte(img_rgb);

[img_result1, img_bw] = kmeans(img_rgb, img_bw);

% img_rgb(:, :, 1) = histeq( img_rgb(:, :, 1) );
% img_rgb(:, :, 2) = histeq( img_rgb(:, :, 2) );
% img_rgb(:, :, 3) = histeq( img_rgb(:, :, 3) );

[img_result2, img_bw] = kmeans(img_rgb, img_bw);
[img_result3, img_bw] = kmeans(img_rgb, img_bw);
[img_result4, img_bw] = kmeans(img_rgb, img_bw);

figure;imshow([img_rgb, img_skin, img_result1; img_result2, img_result3, img_result4]);

figure;
subplot(211);imhist(rgb2gray( uint8(img_rgb) ));
subplot(212);imhist(rgb2gray( uint8(img_result4) ));

img_result4(:, :, 1) = histeq( img_result4(:, :, 1) );
img_result4(:, :, 2) = histeq( img_result4(:, :, 2) );
img_result4(:, :, 3) = histeq( img_result4(:, :, 3) );
figure;imshow( uint8(255 * (img_result4) ) );