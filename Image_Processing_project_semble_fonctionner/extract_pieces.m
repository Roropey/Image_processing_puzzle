function [images_crop,count] = extract_pieces(image)


image_bin = im2gray(image)>0; % Transforming the image in binary
labeledImage = bwlabel(image_bin);

% To see the results of background extraction and labeling
% figure;
% imshow(image_bin)
% figure;
% colored=label2rgb(labeledImage);
% mask=(colored(:,:,1)==255 & colored(:,:,2)==255 & colored(:,:,3)==255);
% colored(cat(3,mask,mask,mask))= 0;
% imshow(colored);

stats = regionprops(labeledImage,'BoundingBox');
% reguionprops detect region on a binary image, connected "white zone" and
% extract information like the list of id of the pixel, the boundary of the
% region

images_crop = {}; % cell to stock the image extract from the original
% max_length = 0;
% Use of a cell because not the same size
for i = 1:numel(stats)
            
    mask_pieces_all = ismember(labeledImage, i) > 0; 
    % Recuperation of only the pieces but on the all image (keeping the size of the image)
    masked_Rgb_Image = bsxfun(@times, image, cast(mask_pieces_all, 'like', image)); 
    % Passing from black and white to RGB
    image_crop = imcrop(masked_Rgb_Image,stats(i).BoundingBox); 
    % Extract only the pieces to not have the all image using the
    % bounding box found with regionprops
    images_crop{i} = image_crop; 
    % Memorizing the pieces
end
count = numel(stats);
end