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
    
    n_max = 0;
    m_max = 0;
    for i = 1 : piece_nbr
        [n, m] = size(Image.piece(i).im);
        if n > n_max
            n_max = n;
        end
        if m > m_max
            m_max = m;
        end  
    end
    
    for i = 1 : piece_nbr
        [np, mp, p] = size(Image.piece(i).im);
        Image.piece(i).im = [ Image.piece(i).im zeros(np,m_max - mp,p) ];
        Image.piece(i).im = [ Image.piece(i).im ; zeros(n_max - np,m_max,p) ];
    end
    
    
    for i=1:size_of_shuffled_im 
        for j = 1 : size_of_shuffled_im
            Shuffled_Image( (i-1)*n_max + 1 : i*n_max , (j-1)*m_max + 1 : j*m_max,:) = Image.piece(shuffling(compteur)).im ;
            compteur = compteur + 1 ;
        end
    end

    
end
