%% Create a puzzled version of an image
clear; close all; clc; 

% % Image color
% Image = imread('lena.png','png');
% Image = im2double(Image);
% figure
% imshow(Image)

% % Image black and white
% Image = imread('cameraman.tif','tif');
% Image = im2double(Image);
% figure
% imshow(Image)

% % Image black and white
% Image = imread('zebra.tif','tif');
% Image = im2double(Image);
% figure
% imshow(Image)

% % Image black and white
% Image = imread('mandrill.tif','tif');
% Image = im2double(Image);
% figure
% imshow(Image)

% % Image rectangle
% Image = imread('trees.png','png');
% Image = im2double(Image);
% figure
% imshow(Image)
% 
% nbrPieces = 9; % Select between 4,9 or 16
% 
% Image = cutImage(Image,nbrPieces);
% 
% [M,N,L] = size(Image);
% R = round(min([M,N])/10);
% 
% PuzzledImage = PuzzleCreator(Image,nbrPieces,R);
% figure
% imshow(PuzzledImage.im9(2).im)

% load('imageToReconstruct.mat')
% figure
% imshow(y)
% title('Original image')
% reconstructedImage = reformImage(y, 10, 9);

% load('4_pieces.mat')
% figure
% imshow(y)
% title('Original image')
% reconstructedImage = reformImage(y, 10, 4);

% load('16_piece.mat')
% figure
% imshow(y)
% title('Original image')
% reconstructedImage = reformImage(y, 140, 16);

% load('image_sam_16.mat')
% figure
% imshow(y)
% title('Original image')
% reconstructedImage = reformImage(y, 13, 16);

% load('image_sam_9.mat')
% figure
% imshow(y)
% title('Original image')
% reconstructedImage = reformImage(y, 13, 9);

% figure;
% imshow(reconstructedImage)
% hold on;
% rectangle('Position',[800,2100,300,300],'EdgeColor','r','LineWidth',2)
% title('Final result')
% success(reconstructedImage)

load("pieces_rotated.mat")
Image = piece(3).im;
figure; imshow(Image)
Image = cat(2,Image,Image);
figure; imshow(Image)
R = 65; nbrPieces = 2;

outImage = testReform(Image, R, nbrPieces);

% SE = strel('rectangle',[3 3]);
% Image = imdilate(Image,SE);
% figure; imshow(Image)
% 
% 
% SE = strel('rectangle',[3 3]);
% Image = imerode(Image,SE);
% figure; imshow(Image)












