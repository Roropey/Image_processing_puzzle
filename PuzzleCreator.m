function PuzzledImage = PuzzleCreator(Image,nbrPieces,R)

    % ENTREES:
    % Image: Image rgb ou bw en format double
    % nbrPieces: Nombre de pièces de puzzle (4,9 ou 16 pour le moment). 
    % L'idée est d'avoir le même nombre de pièces vecticalement et
    % horizontalement (idéalement image carrée)

    [M,N,~] = size(Image);
    [x,y] = meshgrid(1:N,1:M);
    pieces = struct; % Permet de retourner les pièces dans une structure
    nppr = sqrt(nbrPieces); % Récupère le nombre de pièce voulue (aussi bien verticalement qu'horizontalement)
    masks = zeros(M,N,nbrPieces); % Le mask est un hyper-cube de N x M x nombre de pièces du puzzle
    ind = 1;
    
    switch nbrPieces

        case 4 % Si 4 pièces
           
        for i = 1:nppr % Itère sur les y
            for j = 1:nppr % itère sur les x
                masks((i-1) * (M/nppr) + 1:i * (M/nppr), (j-1) * (N/nppr) + 1:j * (N/nppr), ind) = 1; % Place des carrés blancs 
                ind = ind + 1;                
                if i == 1 && j == 1 % Si pièce en haut à gauche                    
                    x0_add = ((1/2)*N); % Définis le centre du demi-cercle
                    y0_add = ((1/4)*M);
                    masks(:,:,1) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,1),'right','add'); % Appelle la fonction pour dessiner un demi-cercle ('add' car on rajoute le demi-cercle blanc)
                    x0_remove = ((1/4)*N);
                    y0_remove = ((1/2)*M);
                    masks(:,:,1) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,1),'up','remove'); % Appelle la fonction pour dessiner un demi-cercle ('remove' car on retire le demi-cercle blanc)
                    mask = applyMask(Image,masks(:,:,1));
                    
                    piece = centerImage(mask, M, N, R, nppr, 1);
                    pieces.im4(1).im = piece;
                elseif i == 1 && j == 2 % Si pièce en haut à droite
                    x0_add = ((3/4)*N);
                    y0_add = ((1/2)*M);
                    masks(:,:,2) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,2),'bottom','add');
                    x0_remove = ((1/2)*N)+1;
                    y0_remove = ((1/4)*M);
                    masks(:,:,2) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,2),'right','remove');
                    mask = applyMask(Image,masks(:,:,2));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 2);
                    pieces.im4(2).im = piece;
                elseif i == 2 && j == 1 % Si pièce en bas à gauche
                    x0_add = ((1/4)*N);
                    y0_add = ((1/2)*M)+1;
                    masks(:,:,3) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,3),'up','add');
                    x0_remove = ((1/2)*N);
                    y0_remove = ((3/4)*M);
                    masks(:,:,3) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,3),'left','remove');
                    mask = applyMask(Image,masks(:,:,3));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 3);
                    pieces.im4(3).im = piece;
                else % Si pièce en bas à droite
                    x0_add = ((1/2)*N)+1;
                    y0_add = ((3/4)*M);
                    masks(:,:,4) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,4),'left','add');
                    x0_remove = ((3/4)*N);
                    y0_remove = ((1/2)*M)+1;
                    masks(:,:,4) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,4),'bottom','remove');
                    mask = applyMask(Image,masks(:,:,4));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 4);
                    pieces.im4(4).im = piece;
                end    
            end
        end

%         figure
%         for i = 1:nbrPieces
%             subplot(2,2,i)
%             imshow(masks(:,:,i))
%         end
% 
%         figure
%         for i = 1:nbrPieces
%             subplot(2,2,i)
%             imshow(pieces.im4(i).im)
%         end

        case 9 % Si 9 pièces
            
        for i = 1:nppr % Itère sur les y
            for j = 1:nppr % itère sur les x
                masks((i-1) * (M/nppr) + 1:i * (M/nppr),(j-1) * (N/nppr) + 1:j * (N/nppr), ind) = 1; % Place des carrés blancs 
                ind = ind + 1;
                if i == 1 && j == 1 % Si pièce en haut à gauche
                    x0_add = ((1/3)*N); % Définis le centre du demi-cercle
                    y0_add = ((1/6)*M);
                    masks(:,:,1) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,1),'right','add'); % Appelle la fonction pour dessiner un demi-cercle ('add' car on rajoute le demi-cercle blanc)
                    x0_remove = ((1/6)*N);
                    y0_remove = ((1/3)*M);
                    masks(:,:,1) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,1),'up','remove'); % Appelle la fonction pour dessiner un demi-cercle ('remove' car on retire le demi-cercle blanc)
                    mask = applyMask(Image,masks(:,:,1));
                    
                    piece = centerImage(mask, M, N, R, nppr, 1);
                    pieces.im9(1).im = piece;
                elseif i == 1 && j == 2 % Si pièce en haut au milieu
                    x0_add = ((2/3)*N);
                    y0_add = ((1/6)*M);
                    masks(:,:,2) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,2),'right','add');
                    x0_remove = ((1/3)*N)+1;
                    y0_remove = ((1/6)*M);
                    masks(:,:,2) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,2),'right','remove');
                    x0_remove = ((1/2)*N);
                    y0_remove = ((1/3)*M);
                    masks(:,:,2) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,2),'up','remove');
                    mask = applyMask(Image,masks(:,:,2));
                                        
                    piece = centerImage(mask, M, N, R, nppr, 2);
                    pieces.im9(2).im = piece;
                elseif i == 1 && j == 3 % Si pièce en haut à droite
                    x0_add = ((5/6)*N);
                    y0_add = ((1/3)*M);
                    masks(:,:,3) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,3),'bottom','add');
                    x0_remove = ((2/3)*N)+1;
                    y0_remove = ((1/6)*M);
                    masks(:,:,3) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,3),'right','remove');
                    mask = applyMask(Image,masks(:,:,3));
                                      
                    piece = centerImage(mask, M, N, R, nppr, 3);
                    pieces.im9(3).im = piece;
                elseif i == 2 && j == 1 % Si pièce au milieu à gauche
                    x0_add = ((1/6)*N);
                    y0_add = ((1/3)*M)+1;
                    masks(:,:,4) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,4),'up','add');
                    x0_add = ((1/3)*N);
                    y0_add = ((1/2)*M);
                    masks(:,:,4) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,4),'right','add');
                    x0_remove = ((1/6)*N);
                    y0_remove = ((2/3)*M);
                    masks(:,:,4) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,4),'up','remove');
                    mask = applyMask(Image,masks(:,:,4));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 4);
                    pieces.im9(4).im = piece;
                elseif i == 2 && j == 2 % Si pièce au milieu au milieu
                    x0_add = ((1/2)*N);
                    y0_add = ((1/3)*M)+1;
                    masks(:,:,5) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,5),'up','add');
                    x0_add = ((1/2)*N);
                    y0_add = ((2/3)*M);
                    masks(:,:,5) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,5),'bottom','add');
                    x0_remove = ((1/3)*N)+1;
                    y0_remove = ((1/2)*M);
                    masks(:,:,5) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,5),'right','remove');
                    x0_remove = ((2/3)*N);
                    y0_remove = ((1/2)*M);
                    masks(:,:,5) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,5),'left','remove');
                    mask = applyMask(Image,masks(:,:,5));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 5);
                    pieces.im9(5).im = piece;
                elseif i == 2 && j == 3 % Si pièce au milieu à droite
                    x0_add = ((2/3)*N)+1;
                    y0_add = ((1/2)*M);
                    masks(:,:,6) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,6),'left','add');
                    x0_add = ((5/6)*N);
                    y0_add = ((2/3)*M);
                    masks(:,:,6) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,6),'bottom','add');
                    x0_remove = ((5/6)*N);
                    y0_remove = ((1/3)*M)+1;
                    masks(:,:,6) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,6),'bottom','remove');
                    mask = applyMask(Image,masks(:,:,6));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 6);
                    pieces.im9(6).im = piece;
                elseif i == 3 && j == 1 % Si pièce en bas à gauche
                    x0_add = ((1/6)*N);
                    y0_add = ((2/3)*M)+1;
                    masks(:,:,7) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,7),'up','add');
                    x0_remove = ((1/3)*N);
                    y0_remove = ((5/6)*M);
                    masks(:,:,7) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,7),'left','remove');
                    mask = applyMask(Image,masks(:,:,7));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 7);
                    pieces.im9(7).im = piece;
                elseif i == 3 && j == 2 % Si pièce en bas au milieu
                    x0_add = ((1/3)*N)+1;
                    y0_add = ((5/6)*M);
                    masks(:,:,8) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,8),'left','add');
                    x0_remove = ((1/2)*N);
                    y0_remove = ((2/3)*M)+1;
                    masks(:,:,8) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,8),'bottom','remove');
                    x0_remove = ((2/3)*N);
                    y0_remove = ((5/6)*M);
                    masks(:,:,8) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,8),'left','remove');
                    mask = applyMask(Image,masks(:,:,8));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 8);
                    pieces.im9(8).im = piece;
                else % Si pièce en bas à droite
                    x0_add = ((2/3)*N)+1;
                    y0_add = ((5/6)*M);
                    masks(:,:,9) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,9),'left','add');
                    x0_remove = ((5/6)*N);
                    y0_remove = ((2/3)*M)+1;
                    masks(:,:,9) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,9),'bottom','remove');
                    mask = applyMask(Image,masks(:,:,9));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 9);
                    pieces.im9(9).im = piece;
                end    
            end
        end

%         figure
%         for i = 1:nbrPieces
%             subplot(3,3,i)
%             imshow(masks(:,:,i))
%         end

%         figure
%         for i = 1:nbrPieces
%             subplot(3,3,i)
%             imshow(pieces.im9(i).im)
%         end

        case 16 % Si 16 pièces
            
        for i = 1:nppr % Itère sur les y
            for j = 1:nppr % itère sur les x
                masks((i-1) * (M/nppr) + 1:i * (M/nppr),(j-1) * (N/nppr) + 1:j * (N/nppr), ind) = 1; % Place des carrés blancs 
                ind = ind + 1;
                if i == 1 && j == 1 
                    x0_add = ((1/4)*N); % Définis le centre du demi-cercle
                    y0_add = ((1/8)*M);
                    masks(:,:,1) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,1),'right','add'); % Appelle la fonction pour dessiner un demi-cercle ('add' car on rajoute le demi-cercle blanc)
                    x0_remove = ((1/8)*N);
                    y0_remove = ((1/4)*M);
                    masks(:,:,1) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,1),'up','remove'); % Appelle la fonction pour dessiner un demi-cercle ('remove' car on retire le demi-cercle blanc)
                    mask = applyMask(Image,masks(:,:,1));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 1);
                    pieces.im16(1).im = piece;
                elseif i == 1 && j == 2 
                    x0_add = ((1/2)*N);
                    y0_add = ((1/8)*M);
                    masks(:,:,2) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,2),'right','add');
                    x0_remove = ((1/4)*N)+1;
                    y0_remove = ((1/8)*M);
                    masks(:,:,2) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,2),'right','remove');
                    x0_remove = ((3/8)*N);
                    y0_remove = ((1/4)*M);
                    masks(:,:,2) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,2),'up','remove');
                    mask = applyMask(Image,masks(:,:,2));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 2);
                    pieces.im16(2).im = piece;
                elseif i == 1 && j == 3 
                    x0_add = ((3/4)*N);
                    y0_add = ((1/8)*M);
                    masks(:,:,3) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,3),'right','add');
                    x0_remove = ((1/2)*N)+1;
                    y0_remove = ((1/8)*M);
                    masks(:,:,3) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,3),'right','remove');
                    x0_remove = ((5/8)*N);
                    y0_remove = ((1/4)*M);
                    masks(:,:,3) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,3),'up','remove');
                    mask = applyMask(Image,masks(:,:,3));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 3);
                    pieces.im16(3).im = piece;
                elseif i == 1 && j == 4
                    x0_add = ((7/8)*N);
                    y0_add = ((1/4)*M);
                    masks(:,:,4) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,4),'bottom','add');
                    x0_remove = ((3/4)*N)+1;
                    y0_remove = ((1/8)*M);
                    masks(:,:,4) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,4),'right','remove');
                    mask = applyMask(Image,masks(:,:,4));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 4);
                    pieces.im16(4).im = piece;
                elseif i == 2 && j == 1 
                    x0_add = ((1/8)*N);
                    y0_add = ((1/4)*M)+1;
                    masks(:,:,5) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,5),'up','add');
                    x0_add = ((1/4)*N);
                    y0_add = ((3/8)*M);
                    masks(:,:,5) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,5),'right','add');
                    x0_remove = ((1/8)*N);
                    y0_remove = ((1/2)*M);
                    masks(:,:,5) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,5),'up','remove');                   
                    mask = applyMask(Image,masks(:,:,5));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 5);
                    pieces.im16(5).im = piece;
                elseif i == 2 && j == 2 
                    x0_add = ((3/8)*N);
                    y0_add = ((1/4)*M)+1;
                    masks(:,:,6) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,6),'up','add');
                    x0_add = ((3/8)*N);
                    y0_add = ((1/2)*M);
                    masks(:,:,6) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,6),'bottom','add');
                    x0_remove = ((1/4)*N)+1;
                    y0_remove = ((3/8)*M);
                    masks(:,:,6) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,6),'right','remove');
                    x0_remove = ((1/2)*N);
                    y0_remove = ((3/8)*M);
                    masks(:,:,6) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,6),'left','remove');
                    mask = applyMask(Image,masks(:,:,6));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 6);
                    pieces.im16(6).im = piece;
                elseif i == 2 && j == 3 
                    x0_add = ((5/8)*N);
                    y0_add = ((1/4)*M)+1;
                    masks(:,:,7) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,7),'up','add');
                    x0_add = ((5/8)*N);
                    y0_add = ((1/2)*M);
                    masks(:,:,7) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,7),'bottom','add');
                    x0_add = ((1/2)*N)+1;
                    y0_add = ((3/8)*M);
                    masks(:,:,7) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,7),'left','add');
                    x0_remove = ((3/4)*N);
                    y0_remove = ((3/8)*M);
                    masks(:,:,7) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,7),'left','remove');                    
                    mask = applyMask(Image,masks(:,:,7));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 7);
                    pieces.im16(7).im = piece;
                elseif i == 2 && j == 4 
                    x0_add = ((3/4)*N)+1;
                    y0_add = ((3/8)*M);
                    masks(:,:,8) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,8),'left','add');
                    x0_add = ((7/8)*N);
                    y0_add = ((1/2)*M);
                    masks(:,:,8) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,8),'bottom','add');                    
                    x0_remove = ((7/8)*N);
                    y0_remove = ((1/4)*M)+1;
                    masks(:,:,8) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,8),'bottom','remove');
                    mask = applyMask(Image,masks(:,:,8));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 8);
                    pieces.im16(8).im = piece;
                elseif i == 3 && j == 1
                    x0_add = ((1/8)*N);
                    y0_add = ((1/2)*M)+1;
                    masks(:,:,9) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,9),'up','add');
                    x0_add = ((1/4)*N);
                    y0_add = ((5/8)*M);
                    masks(:,:,9) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,9),'right','add');                   
                    x0_remove = ((1/8)*N);
                    y0_remove = ((3/4)*M);
                    masks(:,:,9) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,9),'up','remove');
                    mask = applyMask(Image,masks(:,:,9));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 9);
                    pieces.im16(9).im = piece;
                elseif i == 3 && j == 2                    
                    x0_remove = ((1/4)*N)+1;
                    y0_remove = ((5/8)*M);
                    masks(:,:,10) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,10),'right','remove');
                    x0_remove = ((1/2)*N);
                    y0_remove = ((5/8)*M);
                    masks(:,:,10) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,10),'left','remove');
                    x0_remove = ((3/8)*N);
                    y0_remove = ((1/2)*M)+1;
                    masks(:,:,10) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,10),'bottom','remove');
                    x0_remove = ((3/8)*N);
                    y0_remove = ((3/4)*M);
                    masks(:,:,10) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,10),'up','remove');
                    mask = applyMask(Image,masks(:,:,10));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 10);
                    pieces.im16(10).im = piece;
                elseif i == 3 && j == 3 
                    x0_add = ((1/2)*N)+1;
                    y0_add = ((5/8)*M);
                    masks(:,:,11) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,11),'left','add');
                    x0_remove = ((5/8)*N);
                    y0_remove = ((1/2)*M)+1;
                    masks(:,:,11) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,11),'bottom','remove');
                    x0_remove = ((5/8)*N);
                    y0_remove = ((3/4)*M);
                    masks(:,:,11) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,11),'up','remove');
                    x0_remove = ((3/4)*N);
                    y0_remove = ((5/8)*M);
                    masks(:,:,11) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,11),'left','remove');
                    mask = applyMask(Image,masks(:,:,11));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 11);
                    pieces.im16(11).im = piece;
                elseif i == 3 && j == 4 
                    x0_add = ((3/4)*N)+1;
                    y0_add = ((5/8)*M);
                    masks(:,:,12) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,12),'left','add');
                    x0_add = ((7/8)*N);
                    y0_add = ((3/4)*M);
                    masks(:,:,12) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,12),'bottom','add');                    
                    x0_remove = ((7/8)*N);
                    y0_remove = ((1/2)*M)+1;
                    masks(:,:,12) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,12),'bottom','remove');
                    mask = applyMask(Image,masks(:,:,12));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 12);
                    pieces.im16(12).im = piece;
                elseif i == 4 && j == 1
                    x0_add = ((1/8)*N);
                    y0_add = ((3/4)*M)+1;
                    masks(:,:,13) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,13),'up','add');                    
                    x0_remove = ((1/4)*N);
                    y0_remove = ((7/8)*M);
                    masks(:,:,13) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,13),'left','remove');
                    mask = applyMask(Image,masks(:,:,13));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 13);
                    pieces.im16(13).im = piece;
                elseif i == 4 && j == 2 
                    x0_add = ((1/4)*N)+1;
                    y0_add = ((7/8)*M);
                    masks(:,:,14) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,14),'left','add');
                    x0_add = ((3/8)*N);
                    y0_add = ((3/4)*M)+1;
                    masks(:,:,14) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,14),'up','add');                    
                    x0_remove = ((1/2)*N);
                    y0_remove = ((7/8)*M);
                    masks(:,:,14) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,14),'left','remove');
                    mask = applyMask(Image,masks(:,:,14));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 14);
                    pieces.im16(14).im = piece;
                elseif i == 4 && j == 3
                    x0_add = ((1/2)*N)+1;
                    y0_add = ((7/8)*M);
                    masks(:,:,15) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,15),'left','add');
                    x0_add = ((5/8)*N);
                    y0_add = ((3/4)*M)+1;
                    masks(:,:,15) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,15),'up','add');                    
                    x0_remove = ((3/4)*N);
                    y0_remove = ((7/8)*M);
                    masks(:,:,15) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,15),'left','remove');
                    mask = applyMask(Image,masks(:,:,15));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 15);
                    pieces.im16(15).im = piece;
                else 
                    x0_add = ((3/4)*N)+1;
                    y0_add = ((7/8)*M);
                    masks(:,:,16) = drawHalfCircle(x,y,x0_add,y0_add,R,masks(:,:,16),'left','add');
                    x0_remove = ((7/8)*N);
                    y0_remove = ((3/4)*M)+1;
                    masks(:,:,16) = drawHalfCircle(x,y,x0_remove,y0_remove,R,masks(:,:,16),'bottom','remove');
                    mask = applyMask(Image,masks(:,:,16));
                    
                    
                    piece = centerImage(mask, M, N, R, nppr, 16);
                    pieces.im16(16).im = piece;
                end    
            end
        end

%         figure
%         for i = 1:nbrPieces
%             subplot(4,4,i)
%             imshow(masks(:,:,i))
%         end
% 
%         figure
%         for i = 1:nbrPieces
%             subplot(4,4,i)
%             imshow(pieces.im16(i).im)
%         end

    end

    PuzzledImage = pieces;

end