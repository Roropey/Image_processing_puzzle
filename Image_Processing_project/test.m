close all; clc ; clear;
im = load('Piece.mat') ;

image = im.a ;
imshow(image)
res = edge_detector(image);