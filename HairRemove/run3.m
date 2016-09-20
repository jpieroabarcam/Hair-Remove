clc;clear;close all;
warning('off');

[filename, pathname] = uigetfile('../*.*', '读取图片文件');
pathfile = fullfile(pathname, filename);
if filename == 0
    return;
end
img_rgb = imread(pathfile);
[row, col, dim] = size(img_rgb);
if dim ~= 3
    return;
end
img_src = img_rgb;
% img_rgb = imag_improve_rgb(img_rgb);
img_rgb = preProccess(img_rgb, row, col);
 
r = img_rgb(:, :, 1);
g = img_rgb(:, :, 2);
b = img_rgb(:, :, 3);

% bw_skin = SkinDetecte(r, g, b, row, col);                                  % 肤色检测
bw_img = zeros(row, col);
pos_skin = ( r > 95 & g > 40 & b > 20 & r > g & r > b & max( max(r, b), g) - min( min(r, b), g ) > 15 & abs(r - g) > 15 ) ;
bw_img(pos_skin) = 1;

[L, ~] = bwlabeln(bw_img, 4);                                              % 四连通域
S = regionprops(L, 'Area');
bw_img = ismember(L, find([S.Area] >= 500));

[L, ~] = bwlabeln(1 - bw_img, 4);                                          % 四连通域
S = regionprops(L, 'Area');
bw_img = 1 - ismember(L, find([S.Area] >= 500));

% bw_img = imdilate(bw_img, strel('disk', 3), 1);% 膨胀
% bw_img = imerode(bw_img, strel('disk', 3), 1);% 腐蚀

bw_img = uint8(bw_img);
img_res(:, :, 1) = r .* bw_img;
img_res(:, :, 2) = g .* bw_img;
img_res(:, :, 3) = b .* bw_img;
figure;imshow([img_rgb, img_res]);