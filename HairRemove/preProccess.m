function img_res = preProccess(img_rgb)
% img_rgb = double(img_rgb);
% img_total = img_rgb(:, :, 1) + img_rgb(:, :, 1) + img_rgb(:, :, 1) + eps;
% img_res(:, :, 1) = 255 * img_rgb(:, :, 1) ./ img_total;
% img_res(:, :, 2) = 255 * img_rgb(:, :, 2) ./ img_total;
% img_res(:, :, 3) = 255 * img_rgb(:, :, 3) ./ img_total;
% img_res = uint8(img_res);
% 
img_lab = rgb2lab(img_rgb);
img_lab(:, :, 3) = histeq( img_lab(:, :, 3) );
img_res = uint8( 255 * mat2gray( lab2rgb(img_lab) ) );

% img_hsv = rgb2hsv(img_rgb);
% img_hsv(:, :, 3) = histeq( img_hsv(:, :, 3) );
% img_res = uint8( 255 * mat2gray( hsv2rgb(img_hsv) ) );