function shuffeledImage = shuffleImage(Image)
       
    [N,M,L] = size(Image.piece(1).im);
    bool = N == M;
    nbrPieces = length(Image.piece);
    shuffling = randperm(nbrPieces,nbrPieces);
    nppr = sqrt(nbrPieces);
    shuffeledImage = [];
    bonus=60;
    switch bool

        case true
                                    
            row = [];
            for i = 1 : nbrPieces
                image=zeros(N+bonus,M+bonus,L);
                image(bonus/2:N+bonus/2 - 1,bonus/2:M+bonus/2 - 1,:)=Image.piece(shuffling(i)).im;

                Image.piece(shuffling(i)).im = imrotate(image,randi([0,44])*8,'crop'); %[0,4])*90 [0,359]
                %figure; imshow(Image.piece(i).im)
                if mod(i,nppr) ~= 0
                    row = [row Image.piece(shuffling(i)).im zeros(N+bonus,1,L)];
                else
                    row = [row Image.piece(shuffling(i)).im];
                    row = [row ; zeros(1,nppr*(M+bonus)+nppr-1,L)];
                    shuffeledImage = [shuffeledImage ; row];
                    row = [];
                end
            end

        case false
            
            for i = 1 : nbrPieces
                image=zeros(N+bonus,M+bonus,L);
                image(bonus/2:N+bonus/2 - 1,bonus/2:M+bonus/2 - 1,:)=Image.piece(i).im;
                Image.piece(i).im = imrotate(image,randi([0,3])*90);
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