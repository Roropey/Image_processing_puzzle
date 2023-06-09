function [imagesCrop,count] = extractPieces(image)

    threshold_gray_binary = 0;
    threshold_min_pixels = 100;
    
    image_gray = im2gray(image)>threshold_gray_binary; % Transforming the image in binary
    labeledImage = bwlabel(image_gray);
    stats = regionprops(labeledImage,'BoundingBox',"PixelList");
    % reguionprops detect region on a binary image, connected "white zone" and
    % extract information like the list of id of the pixel, the boundary of the
    % region
     
    count=0; % variable to count the number of pieces
    imagesCrop = {}; % cell to stock the image extract from the original
    % max_length = 0;
    % Use of a cell because not the same size
    for i = 1:numel(stats)
        if size(stats(i).PixelList,1)<threshold_min_pixels % if the region detected is just noise around, it is not important
            continue;
        else
            count=count+1;        
            cashew_single = ismember(labeledImage, i) > 0; % Recuperation of only the pieces but on the all image (keeping the size of the image)
            maskedRgbImage = bsxfun(@times, image, cast(cashew_single, 'like', image)); % Passing from black and white to RGB
            image_crop = imcrop(maskedRgbImage,stats(i).BoundingBox); % Extract only the pieces to not have the all image
            imagesCrop{count} = image_crop; % Memorizing the pieces
        end
    end
        
end