function y = inv_mse(array1, array2, color)

% y = sum((array1 - array2).* (array1 - array2)) / length(array1);
% y = mean(y);
array1_cleared = array1(array1~=0);
array2_cleared = array2(array2~=0);

if (color == 1)
array1_cleared = reshape(array1_cleared, [], 3);
array2_cleared = reshape(array2_cleared, [], 3);
end
    
taille_max = min(length(array1_cleared),length(array2_cleared));

% y = convn(array1_cleared,array2_cleared(end:-1:1,end:-1:1,end:-1:1));
% y = mean(y);
% y = sum((array1_cleared(1:taille_max,:) - array2_cleared(1:taille_max,:)).* (array1_cleared(1:taille_max,:) - array2_cleared(1:taille_max,:))) / taille_max;
y = immse(array1_cleared(1:taille_max,:), array2_cleared(1:taille_max,:));
y = max(y);
% y = mean(corr2(array1_cleared(1:taille_max,:),array2_cleared(1:taille_max,:)),'ALL');
end