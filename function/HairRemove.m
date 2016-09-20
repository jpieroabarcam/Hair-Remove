function img_res = HairRemove(img_rgb)
[row, col, ~] = size(img_rgb);

img_rgb = preProccess(img_rgb, row, col);
 
r = img_rgb(:, :, 1);
g = img_rgb(:, :, 2);
b = img_rgb(:, :, 3);

bw_img = zeros(row, col);
pos_skin = ( r > 95 & g > 40 & b > 20 & r > g & r > b & max( max(r, b), g) - min( min(r, b), g ) > 15 & abs(r - g) > 15 ) ;
bw_img(pos_skin) = 1;

[L, ~] = bwlabeln(bw_img, 4);                                              % ����ͨ��
S = regionprops(L, 'Area');
bw_img = ismember(L, find([S.Area] >= 500));

[L, ~] = bwlabeln(1 - bw_img, 4);                                          % ����ͨ��
S = regionprops(L, 'Area');
bw_img = 1 - ismember(L, find([S.Area] >= 500));

bw_img = imdilate(bw_img, strel('disk', 3), 1);% ����
bw_img = imerode(bw_img, strel('disk', 3), 1);% ��ʴ

bw_img = uint8(bw_img);
img_res(:, :, 1) = r .* bw_img;
img_res(:, :, 2) = g .* bw_img;
img_res(:, :, 3) = b .* bw_img;
figure;imshow([img_rgb, img_res]);