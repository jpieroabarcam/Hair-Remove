function img_bw = SkinDetecte(r, g, b, row, col)
img_bw = zeros(row, col);
pos_skin = ( r > 95 & g > 40 & b > 20 & r > g & r > b & max( max(r, b), g) - min( min(r, b), g ) > 15 & abs(r - g) > 15 ) ;
img_bw(pos_skin) = 1;