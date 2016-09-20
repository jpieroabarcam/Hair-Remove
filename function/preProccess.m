function img_res = preProccess(img_rgb, M, N)
% img_lab = rgb2lab(img_rgb);
% img_lab(:, :, 3) = adapthisteq( img_lab(:, :, 3) );
% img_res = uint8( 255 * mat2gray( lab2rgb(img_lab) ) );

% ̬ͬ�˲�
rL = 0.2;rH = 5;c = 1;d0 = 10;

img_lab = rgb2lab(img_rgb);
img_b = img_lab(:, :, 3);

img_fft = fft2( log(img_b + eps) );                                         % ȡ����������Ҷ�任

x = repmat( (1 : M)', 1, N );                                               % 1��M��
y = repmat(1 : N, M, 1);                                                    % N��1��
x0 = floor(M / 2) * ones(M, N);
y0 = floor(N / 2) * ones(M, N);

D = (x - x0) .^ 2 + (y - y0) .^ 2;
H = (rH - rL) * ( exp( c * ( -D / (d0 ^ 2) ) ) ) + rL;                      % ��˹̬ͬ�˲�

img_lab(:, :, 3) = real( exp( ifft2( H .* img_fft ) ) );                    % ����Ҷ��任��ȡָ��
img_res = uint8( 255 * mat2gray( lab2rgb(img_lab) ) );