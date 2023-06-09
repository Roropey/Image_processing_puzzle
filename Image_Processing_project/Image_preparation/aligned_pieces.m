function [images_aligned_real,R] = aligned_pieces(images_crop,count)
% aligned_pieces : take all pieces to make them "aligned" and have the same
% size centered in black
%   - images_crop : ceil containing all pieces
%   - count : number of pieces
%--------------------------------------------------------------------------
%   - images_aligned_real : structure that contains all pieces aligned and
%   centered in a image of the same size

% applying to all pieces the algorithm to rotate them
images_aligned_tmp=struct;
% Measure of the radius of the part added
R=0;
for i=1:count   
   % Put the image in black and white (binary image)
   bin_image_crop = im2gray(images_crop{i})>0;
   % Find the angle of the piece
   [~,angle]=aligned_image(bin_image_crop,false);
   % Apply the rotation to return to normal
   image_aligned = imrotate(images_crop{i},angle);
   % We remove the maximum of the black border around the pieces for
   % measurement on the pieces
   image_aligned_croped = cropBlackAround(image_aligned);
   % We measure the corners position of the square (piece)
   [upX,upY,downX,downY]=findCorner(image_aligned_croped);
   [sizeX,sizeY,~]=size(image_aligned_croped);
   % We compute the different possible R of the image to keep the greatest
   % R of all pieces. The R can change from pieces to pieces because of the
   % rotation that can be random and so creating pixels disparition
   R = max([R upX upY (sizeX-downX) (sizeY-downY)]);
   % We saved the image for the next step
   images_aligned_tmp(i).image=image_aligned_croped;
   images_aligned_tmp(i).corners=[upX,upY,downX,downY];
end

% Centered process to have a cell containing pieces in the same image, and
% centered in the black imaged.
images_aligned_real=struct;
for i=1:count   
   % We take the image informations
   image_aligned = images_aligned_tmp(i).image;
   [sizeX,sizeY,colors]=size(image_aligned);
   upX = images_aligned_tmp(i).corners(1);
   upY = images_aligned_tmp(i).corners(2);
   downX = images_aligned_tmp(i).corners(3);
   downY = images_aligned_tmp(i).corners(4);
   % We find the image size needed to have a centered piece with a black
   % border corresponding to the radius value (and so added part touch
   % normally the image border)
   new_sizeX = sizeX + R - upX + R - (sizeX-downX)-3;
   new_sizeY = sizeY + R - upY + R - (sizeY-downY)-3;
   image_centered = zeros(new_sizeX,new_sizeY,colors);
   % We place the piece on the image and saved it for the next part.
   image_centered(R - upX+1:(sizeX+R - upX),R - upY+1:(sizeY+R - upY),:)=image_aligned;
   image_centered = cast(image_centered,"like",image_aligned);
   images_aligned_real.piece(i).im=image_centered;
end    
end