%% Create a puzzled version of an image
clear; close all; clc; 
addpath("C:\Users\32494\OneDrive\Bureau\Scolarite\MA1\Image Processing\Project\Image_Processing_project\Image_preparation")
addpath("C:\Users\32494\OneDrive\Bureau\Scolarite\MA1\Image Processing\Project\Image_Processing_project\Functions_puzzle_resolution");
addpath("C:\Users\32494\OneDrive\Bureau\Scolarite\MA1\Image Processing\Project\Image_Processing_project\Functions_puzzle_pieces");
% Image black and white
Image = imread('mandrill.tif','tif');
Image = im2double(Image);
figure
imshow(Image)
nbrPieces = 16;
Image = cutImage(Image,nbrPieces);
[M,N,L] = size(Image);
R = round(min([M,N])/20);
PuzzledImage = PuzzleCreator(Image,nbrPieces,R);

shuffled_image = shuffle_color(PuzzledImage);
figure ; imshow(shuffled_image);

y = image_reconstruct(PuzzledImage, nbrPieces,0,R);
y_reformed = reformImage(y,R,nbrPieces);
figure
imshow(y_reformed)
title('Final result')
% Image rectangular
Image = imread('trees.tif');
Image = im2double(Image);
figure
imshow(Image)
nbrPieces = 16; % Select between 4,9 or 16
Image = cutImage(Image,nbrPieces);
[M,N,L] = size(Image);
R = round(min([M,N])/20);
PuzzledImage = PuzzleCreator(Image,nbrPieces,R);
figure; imshow(PuzzledImage.piece(2).im);
y = image_reconstruct(PuzzledImage, nbrPieces,0,R);
y_reformed = reformImage(y,R,nbrPieces);
figure
imshow(y_reformed)

% Image rectangle
Image = imread('lena.png');
Image = im2double(Image);
figure
imshow(Image)
nbrPieces = 16; % Select between 4,9 or 16
Image = cutImage(Image,nbrPieces);
[M,N,L] = size(Image);
R = round(min([M,N])/20);
%PuzzledImage = PuzzleCreator(Image,nbrPieces,R);
% shuffled_image = shuffle_color(PuzzledImage);
% figure ; imshow(shuffled_image)
PuzzledImage = load("pieces_rotated.mat");
y = image_reconstruct(PuzzledImage, nbrPieces,1,R);
y_reformed = reformImage(y,R,nbrPieces);
figure
imshow(y_reformed)
title('Final Result')


% Image rectangle
Image = imread('test5.jpg');
Image = im2double(Image);
figure
imshow(Image)
nbrPieces = 16; % Select between 4,9 or 16
Image = cutImage(Image,nbrPieces);
[M,N,L] = size(Image);
R = round(min([M,N])/20);
PuzzledImage = PuzzleCreator(Image,nbrPieces,R);
shuffled_image = shuffle_color(PuzzledImage);
figure ; imshow(shuffled_image)

y = image_reconstruct(PuzzledImage, nbrPieces,1,R);
y_reformed = reformImage(y,R,nbrPieces);
figure
imshow(y_reformed)
title('Final Result')






