clc;clear;close all;
warning('off');

[filename, pathname] = uigetfile('../*.*', '读取图片文件');
pathfile = fullfile(pathname, filename);
if filename == 0
    return;
end
img_rgb = imread(pathfile);
if size(img_rgb) ~= 3
    return;
end
img_src = img_rgb;
% img_rgb = imag_improve_rgb(img_rgb);
% img_rgb = preProccess(img_rgb);
 
r = img_rgb(:, :, 1);g = img_rgb(:, :, 2);b = img_rgb(:, :, 3);

[img_skin, bw_skin] = SkinDetecte(img_rgb);
[img_hair, bw_hair] = HairDetecte(img_rgb);

img_res = uint8( zeros( size(img_rgb) ) );
img_resR = uint8( zeros( size(r) ) );
img_resG = img_resR;
img_resB = img_resR;

pos_skin = find(bw_skin == 1 & bw_hair == 0);       % 皮肤（绿）
img_resR(pos_skin) = 0;
img_resG(pos_skin) = 255;
img_resB(pos_skin) = 0;

pos_hair = find(bw_skin == 0 & bw_hair == 1);       % 毛发（蓝）
img_resR(pos_hair) = 0; % r(pos_hair);
img_resG(pos_hair) = 0;
img_resB(pos_hair) = 255;

pos_both = find(bw_skin == 1 & bw_hair == 1);       % 都是（红）
img_resR(pos_both) = 255;
img_resG(pos_both) = 0;
img_resB(pos_both) = 0;

img_res(:, :, 1) = img_resR;
img_res(:, :, 2) = img_resG;
img_res(:, :, 3) = img_resB;

imshow([img_src, img_rgb, img_res]);
title('绿----皮肤     蓝----毛发     红----都是     黑----都不是');