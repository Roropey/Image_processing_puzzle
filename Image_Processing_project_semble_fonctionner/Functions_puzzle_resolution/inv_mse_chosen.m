function y = inv_mse_chosen(array1, array2, color,mode)
% Modification pour pouvoir choisir la mesure avec un argument
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
switch mode

%% corr 3D
    case "corr 3D"
        
        
        % if (color == 1)
        % array1_cleared = reshape(array1_cleared, [], 3);
        % array2_cleared = reshape(array2_cleared, [], 3);
        % end
        y = convn(array1,array2(end:-1:1,end:-1:1,end:-1:1));
        y = mean(y);

%% cross correlation
    case "cross correlation"
        array1_cleared = array1(array1~=0);
        array2_cleared = array2(array2~=0);
        
        if (color == 1)
        array1_cleared = reshape(array1_cleared, [], 3);
        array2_cleared = reshape(array2_cleared, [], 3);
        end
        y_red = mean(xcorr2(array1_cleared(1:taille_max,1), array2_cleared(1:taille_max,1)));
        y_red = y_red(y_red >= max(y_red)/4);
        y_green = mean(xcorr2(array1_cleared(1:taille_max,2), array2_cleared(1:taille_max,2)));
        y_green = y_green(y_green >= max(y_green)/4);
        y_blue = mean(xcorr2(array1_cleared(1:taille_max,3), array2_cleared(1:taille_max,3)));
        y_blue = y_blue(y_blue >= max(y_blue)/4);
        y = [y_red; y_green; y_blue];
        y = (y_green);

%% corr 2D
    case "corr 2D"
        if size(array1,3)==3
            array1=rgb2gray(array1);
            array2=rgb2gray(array2);
        end
        y = corr2(array1,array2);

%% SSIM
    case "ssim"
        y = ssim(array1, array2);

%% Color correlation
    case "color correlation"
        y = corrcoef(array1, array2);
        y = y(1,2);

%% Euclidian distance
    case "euclidian distance"
        % if size(array1,3)==3
        %     array1=rgb2gray(array1);
        %     array2=rgb2gray(array2);
        % end
        y = sum((array1 - array2).^2);
        y_other =sum((array1 - flip(array2,2)).^2);
        y = 1/mean(y);
        y_other = 1/mean(y_other);
        y = max(y,y_other);
%% Norm cross correlation
    case "norm cross correlation"
        if ndims(array1) ==3
            array1 = rgb2gray(array1);
            array2 = rgb2gray(array2);
        end
        if size(array1,1) ~= size(array2,1)
            array1 = array1';
        end
        y = normxcorr2(array1, array2);
        y = mean(max(y ));
        %% Gradient 
    case "Gradient"
        gradient_x1 = imfilter(double(array1), [-1 0 1]);
        gradient_y1 = imfilter(double(array1), [-1; 0; 1]);

        gradient_x2 = imfilter(double(array2), [-1 0 1]);
        gradient_y2 = imfilter(double(array2), [-1; 0; 1]);

        % Calculer la magnitude du gradient pour les deux images
        gradient_magnitude1 = sqrt(gradient_x1.^2 + gradient_y1.^2);
        gradient_magnitude2 = sqrt(gradient_x2.^2 + gradient_y2.^2);

        % Calculer la différence de magnitude du gradient entre les deux images
        y = abs(gradient_magnitude1 - gradient_magnitude2);
        y = mean(y,2);
        y = min(y);
end
end