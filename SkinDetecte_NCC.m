clc;clear;close all;

[filename, pathname] = uigetfile('../image/*.*', '¶ÁÈ¡Í¼Æ¬ÎÄ¼þ');
pathfile = fullfile(pathname, filename);
img_rgb = double( imread(pathfile) );
[row, col, ~] = size(img_rgb);

R = img_rgb(:, :, 1);
G = img_rgb(:, :, 2);
B = img_rgb(:, :, 3);

r = R ./ (R + G + B);
g = G ./ (R + G + B);

Au = -1.3767;   Ad = -0.776;
bu = 1.0743;    bd = 0.5601;
cu = 0.1452;    cd = 0.1766;

Qplus = Au * (r .^ 2) + bu * r + cu;
Qduce = Ad * (r .^ 2) + bd * r + cd;
W = (r - 0.33) .^ 2 + (g - 0.33) .^ 2;

requ1 = g < Qplus;
requ2 = g > Qduce;
requ3 = W > 0.004;
requ4 = r >= 0.2 & r <= 0.6;
figure;imshow( uint8(255 * ([requ1, requ2; requ3, requ4])) );

a = zeros(row, col);
a(g < Qplus & g > Qduce & W > 0.004 & r >= 0.2 & r <= 0.6) = 1;
figure;imshow( uint8(255 * a) );

