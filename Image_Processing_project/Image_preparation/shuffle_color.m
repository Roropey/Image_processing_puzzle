function shuffeledImage = shuffle_color(Image)
       
    [N,M,L] = size(Image.piece(1).im);
    bool = N == M;
    nbrPieces = length(Image.piece);
    shuffling = randperm(nbrPieces,nbrPieces);
    nppr = sqrt(nbrPieces);
    shuffeledImage = [];

    switch bool

        case true
                                    
            row = [];
            for i = 1 : nbrPieces
                Image.piece(shuffling(i)).im = rot90(Image.piece(shuffling(i)).im,randi([0,4])); 
                %figure; imshow(Image.piece(i).im)
                if mod(i,nppr) ~= 0
                    row = [row Image.piece(shuffling(i)).im zeros(N,1,L)];
                else
                    row = [row Image.piece(shuffling(i)).im];
                    row = [row ; zeros(1,nppr*M+nppr-1,L)];
                    shuffeledImage = [shuffeledImage ; row];
                    row = [];
                end
            end

        case false
            
            for i = 1 : nbrPieces
                Image.piece(i).im = rot90(Image.piece(i).im,randi([0,4]));
            end
            
            compteur = 1;
            
            n_max = 0;
            m_max = 0;
            for i = 1 : nbrPieces
                [n, m] = size(Image.piece(i).im);
                if n > n_max
                    n_max = n;
                end
                if m > m_max
                    m_max = m;
                end  
            end
            
            for i = 1 : nbrPieces
                [np, mp, p] = size(Image.piece(i).im);
                Image.piece(i).im = [ Image.piece(i).im zeros(np,m_max - mp,p) ];
                Image.piece(i).im = [ Image.piece(i).im ; zeros(n_max - np,m_max,p) ];
            end
            
            
            for i=1:nppr 
                for j = 1 : nppr
                    shuffeledImage( (i-1)*n_max + 1 : i*n_max , (j-1)*m_max + 1 : j*m_max,:) = Image.piece(shuffling(compteur)).im ;
                    compteur = compteur + 1 ;
                end
            end

    end
    
end