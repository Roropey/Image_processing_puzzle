function [Shuffled_Image] = shuffle_image_v2(Image)
    
    piece_nbr = length(Image.piece);
    [n, m] = size(Image.piece(1).im);
    shuffling = randperm(piece_nbr,piece_nbr);
    size_of_shuffled_im = sqrt(piece_nbr);
    
    for i = 1 : piece_nbr
        Image.piece(i).im = imrotate(Image.piece(i).im,randi([0,360]));
    end
    
    Shuffled_Image = [];
    compteur = 1;

    for i=1:size_of_shuffled_im 
        for j = 1 : size_of_shuffled_im
            Shuffled_Image( (i-1)*n + 1 : i*n , (j-1)*m + 1 : j*m,:) = Image.piece(shuffling(compteur)).im ;
            compteur = compteur + 1 ;
        end
    end

    
end
