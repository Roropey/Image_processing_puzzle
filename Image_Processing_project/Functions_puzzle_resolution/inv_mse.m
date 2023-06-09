function y = inv_mse(array1, array2, color)
nnz1 = find(array1(1,:,1));
nnz2 = find(array2(1,:,1));
nnz_comon = intersect(nnz1,nnz2);
array1 = array1(:,nnz_comon,:);
array2 = array2(:,nnz_comon,:);
% y = sum((array1 - array2).* (array1 - array2)) / length(array1);
% y = mean(y);
% array1_cleared = array1(array1~=0);
% array2_cleared = array2(array2~=0);
% 
% if (color == 1)
% array1_cleared = reshape(array1_cleared, [], 3);
% array2_cleared = reshape(array2_cleared, [], 3);
% end

%% corr 3D
% y = convn(array1_cleared,array2_cleared(end:-1:1,end:-1:1,end:-1:1));
% y = mean(y);
% y = sum((array1_cleared(1:taille_max,:) - array2_cleared(1:taille_max,:)).* (array1_cleared(1:taille_max,:) - array2_cleared(1:taille_max,:))) / taille_max;

%% cross correlation
% y_red = mean(xcorr2(array1_cleared(1:taille_max,1), array2_cleared(1:taille_max,1)));
% y_red = y_red(y_red >= max(y_red)/4);
% y_green = mean(xcorr2(array1_cleared(1:taille_max,2), array2_cleared(1:taille_max,2)));
% y_green = y_green(y_green >= max(y_green)/4);
% y_blue = mean(xcorr2(array1_cleared(1:taille_max,3), array2_cleared(1:taille_max,3)));
% y_blue = y_blue(y_blue >= max(y_blue)/4);
% y = [y_red; y_green; y_blue];
% y = (y_green);

%% corr 2D
% y = corr2(array1,array2);

%% SSIM

% y = ssim(array1, array2);

%% Color correlation

% y = corrcoef(array1, array2);
% y = y(1,2);

%% Euclidian distance
y = sum((array1 - array2).^2);
y_other =sum((array1 - flip(array2,2)).^2);
y = 1/mean(y);
y_other = 1/mean(y_other);
y = max(y,y_other);
%% Norm cross correlation
% array1 = rgb2gray(array1);
% array2 = rgb2gray(array2);
% if size(array1,1) ~= size(array2,1)
%     array1 = array1';
% end
% y = normxcorr2(array1, array2);
% y = mean(max(y ));
end