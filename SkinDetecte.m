function [img_skin, img_bw] = SkinDetecte(img_rgb)
[row, col, dim] = size(img_rgb);

r = img_rgb(:, :, 1);
g = img_rgb(:, :, 2);
b = img_rgb(:, :, 3);

img_skin = zeros(row, col, dim);
img_bw = zeros(row, col);

for i = 1 : row
    for j = 1 : col
        if r(i, j) == 0 && g(i, j) == 0 && b(i, j) == 0
            img_bw(i, j ) = 2;
        elseif r(i, j) > 95 && g(i, j) > 40 && b(i, j) > 20 && r(i, j) > g(i, j) && r(i, j) > b(i, j)
            if max( max( r(i, j), b(i, j )), g(i, j) ) - min( min( r(i, j), b(i, j )), g(i, j) ) > 15 && abs( r(i, j) - g(i, j) ) > 15
                img_skin(i, j, 1) = r(i, j);
                img_skin(i, j, 2) = g(i, j);
                img_skin(i, j, 3) = b(i, j);
                img_bw(i, j ) = 1;
            end
        else
            img_skin(i, j, 1) = 0;        % 0 255
            img_skin(i, j, 2) = 0;
            img_skin(i, j, 3) = 0;
        end
    end
end