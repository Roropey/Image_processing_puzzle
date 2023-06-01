clear;
close all;
threshold_gray_binary = 0;
%image = imread("Example_square_black_background.jpg");
load("image_puzzle_romain.mat");
image=shuffled_image;
[images_crop,count] = extract_pieces(image)
figure();
imshow(image);

% applying to all pieces the algorithm to rotate them
images_aligned_tmp={};
max_size=0; % value usefull to dertermine the dimension of the image of 
% pieces to have the same
figure();
for i=1:count   
   subplot(4,count/2,i);
   imshow(images_crop{i});
   title("Pieces crop");
   bin_image_crop = im2gray(images_crop{i})>threshold_gray_binary;%im2bw();
   [~,angle]=aligned_image(bin_image_crop,false);
   image_aligned = imrotate(images_crop{i},angle);
   [sizeX,sizeY,~]=size(image_aligned);
   max_size = max([sizeX sizeY max_size]);
   images_aligned_tmp{i}=image_aligned;
end

% Centered process to have a cell containing pieces in the same image, and
% centered in the black imaged. Possibilities to apply extraction to reduce
% the size of the black countour.
images_aligned_real_bis={};
images_aligned_real={};
for i=1:count   
   image_centered = zeros(max_size,max_size,3);
   image_aligned = images_aligned_tmp{i};
   [sizeX,sizeY,~]=size(image_aligned);
   diffX=round((max_size-sizeX)/2);
   diffY=round((max_size-sizeY)/2);
   image_centered(diffX+1:(sizeX+diffX),diffY+1:(sizeY+diffY),:)=image_aligned;
   image_centered = cast(image_centered,"like",image_aligned);
   % applying a filling with a mask obtained by a modified closing
   [r,g,b]=imsplit(image_centered);
   r_closed=closing(r);
   g_closed=closing(g);
   b_closed=closing(b);
   image_centered_closed = cat(3,r_closed,g_closed,b_closed);
   
   subplot(4,count/2,i+count);    
   imshow(image_centered_closed);
   title("Pieces crop aligned closed");
   images_aligned_real{i}=image_centered_closed;
end    


figure();
image_centered=images_aligned_real{7};
[r,g,b]=imsplit(image_centered);
r_closed=closing(r);
g_closed=closing(g);
b_closed=closing(b);
image_centered_closed = cat(3,r_closed,g_closed,b_closed);
subplot(1,2,2)
imshow(image_centered_closed)
title("Closing fill modified");
subplot(1,2,1)
imshow(image_centered);
title("Original");
