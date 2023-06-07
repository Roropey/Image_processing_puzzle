function [images_aligned_real] = aligned_pieces(images_crop,count)
% aligned_pieces : take all pieces to make them "aligned" and have the same
% size centered in black
%   - images_crop : ceil containing all pieces
%   - count : number of pieces
%--------------------------------------------------------------------------
%   - images_aligned_real : structure that contains all pieces aligned and
%   centered in a image of the same size

% applying to all pieces the algorithm to rotate them
images_aligned_tmp={};
max_size=0; % value usefull to dertermine the dimension of the image of 
% pieces to have the same
for i=1:count   
   % Put the image in black and white (binary image)
   bin_image_crop = im2gray(images_crop{i})>0;
   % Find the angle of the piece
   [~,angle]=aligned_image(bin_image_crop,false);
   % Apply the rotation to return to normal
   image_aligned = imrotate(images_crop{i},angle);
   % Do it a second time just in case
   bin_image_aligned = im2gray(image_aligned)>0;
   [~,angle]=aligned_image(bin_image_aligned,false);
   image_aligned = imrotate(image_aligned,angle);
   
   [sizeX,sizeY,~]=size(image_aligned);
   max_size = max([sizeX sizeY max_size]);
   images_aligned_tmp{i}=image_aligned;
end

% Centered process to have a cell containing pieces in the same image, and
% centered in the black imaged.
images_aligned_real=struct;
for i=1:count   
   image_aligned = images_aligned_tmp{i};
   if size(image_aligned,3)==1
       image_centered = zeros(max_size,max_size,1);
   
       [sizeX,sizeY,~]=size(image_aligned);
       diffX=round((max_size-sizeX)/2);
       diffY=round((max_size-sizeY)/2);
       image_centered(diffX+1:(sizeX+diffX),diffY+1:(sizeY+diffY),:)=image_aligned;
       image_centered = cast(image_centered,"like",image_aligned);
   else
       image_centered = zeros(max_size,max_size,3);
       [sizeX,sizeY,~]=size(image_aligned);
       diffX=round((max_size-sizeX)/2);
       diffY=round((max_size-sizeY)/2);
       image_centered(diffX+1:(sizeX+diffX),diffY+1:(sizeY+diffY),:)=image_aligned;
       image_centered = cast(image_centered,"like",image_aligned);
       % In case of input in uint8 to have the output in uint8 and not double
   end
   images_aligned_real(i).im=image_centered;
end    
end