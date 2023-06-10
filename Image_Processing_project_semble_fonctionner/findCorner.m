function [upX,upY,downX,downY] = findCorner(piece)
% findCorner : find the coordinates of all 4 corners
%   - piece : piece from which we want the corners
%--------------------------------------------------------------------------
%   - upX : coordinate of row for the upper left corner (and so for the
%   upper right)
%   - upY : coordinate of column for the upper left corner (and so for the
%   lower left)
%   - downX : coordinate of row for the lower right corner (and so for the
%   lower left)
%   - downY : coordinate of column for the lower right corner (and so for 
%   the upper right)

solbel_hor = -1*fspecial('prewitt');
solbel_ver = solbel_hor' ;
[~, ~,colors] = size(piece);
if colors > 1
    piece=rgb2gray(piece);
end
Im = hypot(conv2(piece,solbel_hor),conv2(piece,solbel_ver));
[rows, columns] = find(Im);
[n, m] = size(Im);
Px = 1;
Py = 1;
Qx = m;
Qy = n;

% Finding the indexes of 2 point : the nearest coin and the farest one from
% the origin : allows to find the egde lines.
distancesP = sqrt((columns - Px).^2 + (rows - Py) .^ 2);
[~, indexOfMinP] = min(distancesP);
distancesQ = sqrt((columns - Qx).^2 + (rows - Qy) .^ 2);
[~, indexOfMinQ] = min(distancesQ);

upX = rows(indexOfMinP);
upY =columns(indexOfMinP);
downX = rows(indexOfMinQ);
downY = columns(indexOfMinQ);
end