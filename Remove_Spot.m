function img_bw = Remove_Spot(img_bw)
[L, ~] = bwlabel(img_bw, 4);
stats = regionprops(L);
Ar = cat(1, stats.Area);
% ind = find( Ar == max(Ar) );
img_bw( find( L ~= find( Ar == max(Ar) ) ) ) = 0;